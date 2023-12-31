PGDMP         )                {            postgres    15.2    15.2 .    <           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            =           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            >           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false            @           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3391                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            A           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1255    17870 (   find_order_from_email(character varying)    FUNCTION     P  CREATE FUNCTION public.find_order_from_email(input_mail character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
    tmpid char(8);
BEGIN
    SELECT customer_id
    INTO tmpid
    FROM customer
    WHERE email = input_mail;
    
    PERFORM *
    FROM orders
    WHERE customer_id = tmpid;
    
    RETURN 1;
END;
$$;
 J   DROP FUNCTION public.find_order_from_email(input_mail character varying);
       public          postgres    false            �            1255    17632 �   insert_new_customer(character, character varying, character varying, character varying, character, date, character varying, character varying)    FUNCTION     e  CREATE FUNCTION public.insert_new_customer(cuid character, cuname character varying, cuphone character varying, cuaddress character varying, cugender character, cudob date, cuemail character varying, cupassword character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare tmpid char(8);
begin
	select customer_id into tmpid
	from customer
	where customer_id=cuid;
	if(tmpid is not null) then
			return 0;
	else
	insert into customer(customer_id,name,phone_number,address,gender,dob,email,password) values(cuid,cuname,cuphone,cuaddress,cugender,cudob,cuemail,cupassword);
	return 1;
	end if;
end;
$$;
 �   DROP FUNCTION public.insert_new_customer(cuid character, cuname character varying, cuphone character varying, cuaddress character varying, cugender character, cudob date, cuemail character varying, cupassword character varying);
       public          postgres    false            �            1255    17871    new_order(character varying, character, integer, character, character, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.new_order(input_mail character varying, input_productid character, input_quan integer, input_orderid character, input_couponid character, input_paymethod character varying, input_delimethod character varying, input_deliunit character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
    cusid char(8);
	curdate date;
	deli_cost money;
	stat varchar(100);
	np money;
	coupon_dc money;
	pr money;
BEGIN
    SELECT customer_id
    INTO cusid
    FROM customer
    WHERE email = input_mail;
    
	SELECT price
    INTO pr
    FROM product
    WHERE product_id = input_productid;
	
	select CURRENT_DATE into curdate;
	
	if input_delimethod='Express' then
			deli_cost=15;
	end if;
	if input_delimethod='Standard' then
			deli_cost=10;
	end if;
	
	
	if input_couponid='ABC12345' then
			coupon_dc=20;
	end if;
	if input_couponid='DEF23456' then
			coupon_dc=10;
	end if;
	if input_couponid='GHI34567' then
			coupon_dc=15;
	end if;
	if input_couponid='JKL45678' then
			coupon_dc=25;
	end if;
	stat='Processing';
	
	np= pr * input_quan + deli_cost - coupon_dc;
	
	
	
	insert into orders(order_id,status,order_date,payment_method,delivery_method,delivery_unit,delivery_cost,customer_id,coupon_id)
	values (input_orderid,stat,curdate,input_paymethod,input_delimethod,input_deliunit,deli_cost,cusid,input_couponid);
	insert into includes(order_id,product_id,quantity,net_price)
	values (input_orderid,input_productid,input_quan,np);
	
    return 1;
END;
$$;
 	  DROP FUNCTION public.new_order(input_mail character varying, input_productid character, input_quan integer, input_orderid character, input_couponid character, input_paymethod character varying, input_delimethod character varying, input_deliunit character varying);
       public          postgres    false            �            1255    18036    product_in_stock_insert_func()    FUNCTION     �  CREATE FUNCTION public.product_in_stock_insert_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF (SELECT product_in_stock FROM product where product_id = NEW.product_id) < NEW.quantity THEN
        raise notice 'So luong trong kho khong du';
        RETURN NULL;
    ELSE
        UPDATE product
        SET product_in_stock = product_in_stock - NEW.quantity
        WHERE product_id = NEW.product_id;
        RETURN NEW;
    END IF;
END;
$$;
 5   DROP FUNCTION public.product_in_stock_insert_func();
       public          postgres    false            �            1255    18043    total_spent(character)    FUNCTION     �  CREATE FUNCTION public.total_spent(cus_id character) RETURNS money
    LANGUAGE plpgsql
    AS $$

declare total_money money := 0;

        ord_id char(8);

        tmp money;

Begin

for ord_id in (select order_id from orders where customer_id=cus_id) loop

        select net_price into tmp

        from includes as i

        where i.order_id = ord_id;

        total_money = total_money + tmp;

end loop;

return total_money;

end;$$;
 4   DROP FUNCTION public.total_spent(cus_id character);
       public          postgres    false            �            1259    17541    category    TABLE     �   CREATE TABLE public.category (
    category_id character(8) NOT NULL,
    title character varying(100),
    description text
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    17607    coupon    TABLE     �   CREATE TABLE public.coupon (
    coupon_id character(8) NOT NULL,
    coupon_name character varying(100),
    code character varying(100),
    start_time date,
    end_time date,
    quantity integer,
    discount_amount integer
);
    DROP TABLE public.coupon;
       public         heap    postgres    false            �            1259    17560    customer    TABLE     #  CREATE TABLE public.customer (
    customer_id character(8) NOT NULL,
    name character varying(100),
    phone_number character varying(20),
    address character varying(100),
    gender character(1),
    dob date,
    email character varying(100),
    password character varying(100)
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    17565    feedback    TABLE     �   CREATE TABLE public.feedback (
    product_id character(8) NOT NULL,
    customer_id character(8) NOT NULL,
    comment text,
    stars integer
);
    DROP TABLE public.feedback;
       public         heap    postgres    false            �            1259    17592    includes    TABLE     �   CREATE TABLE public.includes (
    order_id character(8) NOT NULL,
    product_id character(8) NOT NULL,
    quantity integer,
    net_price money
);
    DROP TABLE public.includes;
       public         heap    postgres    false            �            1259    17582    orders    TABLE     N  CREATE TABLE public.orders (
    order_id character(8) NOT NULL,
    status character varying(100),
    order_date date,
    payment_method character varying(100),
    delivery_method character varying(100),
    delivery_unit character varying(10),
    delivery_cost money,
    customer_id character(8),
    coupon_id character(8)
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    17548    product    TABLE       CREATE TABLE public.product (
    product_id character(8) NOT NULL,
    brand character varying(100),
    price money,
    description text,
    title character varying(100),
    images text,
    discount integer,
    product_in_stock integer,
    category_id character(8)
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    18038    orderdetails    VIEW     �  CREATE VIEW public.orderdetails AS
 SELECT o.order_id,
    o.order_date,
    c.customer_id,
    c.name,
    p.product_id,
    p.title,
    p.price,
    i.quantity,
    i.net_price
   FROM (((public.orders o
     JOIN public.customer c ON ((o.customer_id = c.customer_id)))
     JOIN public.includes i ON ((o.order_id = i.order_id)))
     JOIN public.product p ON ((i.product_id = p.product_id)));
    DROP VIEW public.orderdetails;
       public          postgres    false    221    217    217    221    220    220    217    218    221    218    220    221            �            1259    17429    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(250) NOT NULL,
    email character varying(250) NOT NULL,
    password character varying(250) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            3          0    17541    category 
   TABLE DATA           C   COPY public.category (category_id, title, description) FROM stdin;
    public          postgres    false    216   �E       9          0    17607    coupon 
   TABLE DATA           o   COPY public.coupon (coupon_id, coupon_name, code, start_time, end_time, quantity, discount_amount) FROM stdin;
    public          postgres    false    222   RF       5          0    17560    customer 
   TABLE DATA           j   COPY public.customer (customer_id, name, phone_number, address, gender, dob, email, password) FROM stdin;
    public          postgres    false    218   G       6          0    17565    feedback 
   TABLE DATA           K   COPY public.feedback (product_id, customer_id, comment, stars) FROM stdin;
    public          postgres    false    219   L       8          0    17592    includes 
   TABLE DATA           M   COPY public.includes (order_id, product_id, quantity, net_price) FROM stdin;
    public          postgres    false    221   M       7          0    17582    orders 
   TABLE DATA           �   COPY public.orders (order_id, status, order_date, payment_method, delivery_method, delivery_unit, delivery_cost, customer_id, coupon_id) FROM stdin;
    public          postgres    false    220   N       4          0    17548    product 
   TABLE DATA           �   COPY public.product (product_id, brand, price, description, title, images, discount, product_in_stock, category_id) FROM stdin;
    public          postgres    false    217   �O       2          0    17429    users 
   TABLE DATA           :   COPY public.users (id, name, email, password) FROM stdin;
    public          postgres    false    215   �X       �           2606    17547    category category_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    216            �           2606    17613    coupon coupon_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (coupon_id);
 <   ALTER TABLE ONLY public.coupon DROP CONSTRAINT coupon_pkey;
       public            postgres    false    222            �           2606    17564    customer customer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    218            �           2606    17571    feedback feedback_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (product_id, customer_id);
 @   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_pkey;
       public            postgres    false    219    219            �           2606    17596    includes includes_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.includes
    ADD CONSTRAINT includes_pkey PRIMARY KEY (order_id, product_id);
 @   ALTER TABLE ONLY public.includes DROP CONSTRAINT includes_pkey;
       public            postgres    false    221    221            �           2606    17586    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    220            �           2606    17554    product product_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    217            �           2606    17435    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2620    18037     includes product_in_stock_insert    TRIGGER     �   CREATE TRIGGER product_in_stock_insert BEFORE INSERT ON public.includes FOR EACH ROW EXECUTE FUNCTION public.product_in_stock_insert_func();
 9   DROP TRIGGER product_in_stock_insert ON public.includes;
       public          postgres    false    224    221            �           2606    17577 "   feedback feedback_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 L   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_customer_id_fkey;
       public          postgres    false    218    3217    219            �           2606    17572 !   feedback feedback_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);
 K   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_product_id_fkey;
       public          postgres    false    219    3215    217            �           2606    17872    product fk1    FK CONSTRAINT     z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk1 FOREIGN KEY (category_id) REFERENCES public.category(category_id);
 5   ALTER TABLE ONLY public.product DROP CONSTRAINT fk1;
       public          postgres    false    216    217    3213            �           2606    17758 
   orders fk2    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk2 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 4   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk2;
       public          postgres    false    218    220    3217            �           2606    17764 
   orders fk3    FK CONSTRAINT     s   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk3 FOREIGN KEY (coupon_id) REFERENCES public.coupon(coupon_id);
 4   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk3;
       public          postgres    false    220    222    3225            �           2606    17597    includes includes_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.includes
    ADD CONSTRAINT includes_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);
 I   ALTER TABLE ONLY public.includes DROP CONSTRAINT includes_order_id_fkey;
       public          postgres    false    220    221    3221            �           2606    17602 !   includes includes_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.includes
    ADD CONSTRAINT includes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);
 K   ALTER TABLE ONLY public.includes DROP CONSTRAINT includes_product_id_fkey;
       public          postgres    false    217    3215    221            �           2606    17587    orders orders_costumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_costumer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 H   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_costumer_id_fkey;
       public          postgres    false    218    3217    220            3   S   x�sv6 CN��܂ļ�TK!<3/U���@�25�����ֈ�=3�!�h�Ɯa�)ى���Π�\F������ o�)�      9   �   x�=���0�s����6��q


�@ԐxY�$|$3jx{7E��i�k+����C��:m�J��sQ$%#��1	1�s�)P�&(N�N.!��F�d�n���g���)Ä��jN��K3gC����Z/֪�\�D��{���F�9P�������o^�<�AH�]�����G�'`�qt[ �>
:6�      5   �  x��W�r�8}�|?`
����q2ٝZ�LM����}��֐����[H��yب�@�8}�ݧ/x�:��u�/��$b~��%o_`��3����Wۜ;z�����m��n��z�=��2?���&=՛��7�2��3�;�ȫӦ��o�����r�YT�'��_�,k1��j���(�¹������U�gÛ�U�C��;m-�Ի��i�y�����u�����hpE^��z��4��6���#s�K�#�G��ƛ�h!5�<p�Ε,���9�3��P�~ ����B��g^�8f��
}��ۼ.wm]A�vu�IC�|�c&r#�f^D%$�v�[
_�rnʢˁ�|�gŋjH�3�3/�ap�鶄�8������r/�s�o*L�Ȼ ���E%�9c�%(I��[�C�(6X�YJ�<����qU�|�cP��pµ1�`!��**DJH�Y;҇�%�f�/�A�J��;���<7��(���H�	��B�ŵ1�I�UY��dBj�l�h�=:�u� �{߃�n:��ŵ�AC��
[��7��>�\Aݼ8�@�O��?���,��G�K@���bM@;��٪���~��O#�$�dI5#Fev��r�u�IVR��i���)Ђ���wol��f��º/�=�D��"�e;&"�O�.�@�1ݙ8A�<F\_E��\�G��S2�%L����}v3[�B>X�B� R
l��i�1M(�ccWX��&���-_)�s�ۼ��5�T͡�p�I��|Fj�̹�/�n �a+>������z������ �7Y<b��TU����Ji�x�
�>)��k_>�x`�9x��f�vu��_����ײ <�V�w��?X����Eë)+�5T�˄�a�̅�y�2�Ō"�bTS���3L�^���h�dFZĽ��nc����Z�������ш�g�j�Y�P�!�bD�\��M�a�=�%viYw�p�RC�R�(�M~���T``ؕBX����红:�M~HtrYcD�J�t�?T�2ǝ��w9��|��SM���}:�Oz��N���p��<�O�->9���������\�
E�K��C6*�#�(6ՆQ�k���;DG=���7]QA�޵iu$4]��V`�T`;���j[�����)Y�<Y�sK��|���;cZԮ~��89<	�U`�I��w֋���n��ߏ�sMn.�]���5�􆤹|3�!޹E��^�Rj���g▰V�ܳ��_T�^�      6   �   x�-�Kr�0DףS�/��3�,R�����9��
�Ae	!S���lz�����I���Q�-�,�ʓ8x��MX�N����S㬥^��LT�:���̋�ֹ�a�c�5�D�����PF܂��O��!c�8��tC({�g�"�'�3?�O��8Z�P9���*�3����k2 ��������v�4���A6���Q�=k_������e1��ʻ������^!� bU}      8      x�m��n�0���9rF��8�1�,�B���P7�UQE_�OI�*�8����ӌ�H�P/�[TB��Ƃ�<GR�^7Eδ7S��ݽ�qy䭪H7�ݥ�9	a,�]�"i��IbO������)���v=�����/��..�l8����q�lF'�M1�'ɘ��/������tx�ah����>[��ݘ�J��g�>f��s�j��y+.}�캗�:���񛮓���k��M��y��� ~ ��f�      7   �  x����R�0�u�.�¤I/d	E���B�
�&� WKE}{�^A:��i��ߜ�OB�aȄ**26��2�Lh�,##�yte��G7�0�����ZV�#����
j��
E�F9�f�|�����@7�k_,̖�X���$�gsI��� �:|	Z���^��k'+)_@a)2�n�L!V��ޥ4 )'B�|\L��FQ�H�}/�L�)�����+���������1�<e�|�u��@02�觶�`��t��=<>	��)kyJh��dec�Q]P��!��i���'v/S����(Fc-`����`�q;}s�'�d>���`~~�[��[��3�����^@P9#��.��5}�@r��W�5{+��?��8��o�Ŗ��A��$I_W�s�      4   �  x����r��������k�RƜz{'km��S�Z�I*7='�Y�T(ڻ��o( �(W�l������?w���W\H�Y�n���4_�o�����	���Yuq��wx�LU^�n�k\�T����k�l6w�?�����|9��~V�����Zc-U�R��0��42K�'#j�z����`3��V��ٳ��a���f��/�X]��0�-sU}��oR��|����|O�{��<�-p8�:�9�!"JM����:ǸQ24�0S��}��q^x߮V����f�˴�BX�w��n�7̣�g�X�P[EAVy�d�I�@x���Qg�;�)�cg��.J��d��n��oV[�'��r�!���.�ur]�6ԝ�����ZX��%m{�I�����\���[̗�G��>�B�֙���P'A�$W�y'�5�T� �	1����,�y�߱�&��OǭT-|���Q&<�<j�>�,p�������T]4�6�!d�S���:-7�%����c��qh�uV�de���I�:;��G�f�����f3��Vg?=Q�K�h��&|�4���0��~�)i���!63Ε3:e��!h���;Zѡm�C���u��q����n@������]5�x����w���)�H:�)��y�č� B�ƚ1yq�r�w�����Y���Y|L]��l�O{I�T�0��3L\ZA��F~vY��(�W��״���o��[�;��:_�����p�	���b8��k���Y5��A0�)gx"�|Wdwm�+M��_iC�]͡V�*G���\��*�9d�D�>̐�Iy�S���uZ4�gҊ`SZ٢�h�a���Lq;�������qN�$����H��sњ��-T'�~~������mgO���ԳY��a���eC���0�&Z�l�g�89��ܘ,�J�����[����N��JW[�E���(�Gf�h!)�A��\Z�r���\�Mn���w�˴��e�6�U�龉�Z�:H
�,���Q��JM̆Q5tl~���7E�vW?��}jp�Yu����о>�r���X. ��̐AG#��R9�����G����R�푫~M�5�=
�󸋛��UC��z�O���<��2���Hi֙�92#���"�ю�A~p��F���ܳ���Sb��f��̻)Ԡ#�h��&[n�<����]54E��J�6�_8�!�f<쐺KLv�4J�(�K*+Y���1�:�R�F4\������DwP9p��S��ņS��5t	5��E��2j72�@�q��%��F6� C�,��K��eN�7�q��L5�2��(Y�T�dL)��ɍ8�,�E�dyۧ���e�������{R�?	J��A��&JI�B�l�4c9#�ds#���h� ��kn`�-��s�-N&X'W'�0��UR1xm��r�(�
n�:�W�~�3ޜ#��b�y�u�����?mߟ�5X��)�<w���C���14�ؽ��?}�۞��0bu��Ҷnb��ο�oָ�Dq��d��E�S�C����43�*���G���c�a�U�����Ǚ��j��6��!�ZP��( es2)y���1m��e�'��}�������I��>��	
�v�G]mH4gj�R���cs���qn�ڒ&a��Vq����:XbʜUi���b<dDk2(�D�M�R2�P㰅S�k���$�&6�k�2u���,�k`o��ʭ����T���y�IRk�6J!B��i�����5Ю@�W��Ǒ�%�d�@Ĭ6@�B�%j���2�L�դ�2��_}� ���ɓ�iwH��O�\̤H�TM!YQ��R��e'��$��5����}4f�Z���M¼=�
yo^V���6���ã������� ��љ	���+߶��Zσɲ�-�N�_c�7�:�(�J&"Q1K��,��wHA�2�R K��v�z�_Ӳq�#���q���T��&\�4J���Z�,�p�S;Wf?j>����i�#�M�w��:���{��=�'X�AS���|K�j�����{ �o�h��冨X�F��{kK�NF�D�t�c2n$a����$KHo�)[kn@e�����!���b&1Sv��IY�-0/��ܥ�e���$s���~���M b�5�Q*�� �4�h�����/�?_��y7�~�L!}O�˷q�7������Ǉ�#m%�e0.F@��&޹x8�I�_~�!}цa�-��ʟ�����O�����b      2   _   x�3�t��M�-��L�����9z�����F�&�f\Ɯ!�y���y����y�y�� ���I�)�U �\F� YT�u`����qqq c^)2     