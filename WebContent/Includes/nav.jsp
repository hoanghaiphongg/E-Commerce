<div class=hd>
<header class="header">
            <div class="grid wide">
                <nav class="header__navbar hide-on-mobile-tablet">
                    <ul class="header__navbar-list">
                        <li class="header__navbar-item">
                            <a href="index.jsp"
                                class="header__navbar-item-link header__navbar-item--separate">Home</a>
                        </li>
                        <li class="header__navbar-item">
                            <a href="cart.jsp"
                                class="header__navbar-item-link header__navbar-item--separate">Customer</a>
                        </li>
                       
                        <li class="header__navbar-item">
                            <a href="order.jsp"
                                class="header__navbar-item-link header__navbar-item--separate">Order</a>
                        </li>
                        <li class="header__navbar-item header__navbar-item--has-qr header__navbar-item--separate">
                            Download App

                            <!-- Header QR Code -->
                            <div class="header__qr">
                                <img class="header__qr-img" src="./assets/img/qr_code.png" alt="QR code">
                                <div class="header__qr-apps">
                                    <a href="" class="header__qr-link">
                                        <img src="./assets/img/googleplay.png" alt="Google Play"
                                            class="header__qr-download-img">
                                    </a>
                                    <a href="" class="header__qr-link">
                                        <img src="./assets/img/appstore.png" alt="Appstore"
                                            class="header__qr-download-img">
                                    </a>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <ul class="header__navbar-list">
                        <li class="header__navbar-item header__navbar-item--has-notify">
                            <a href="#" class="header__navbar-item-link">
                                <i class="header__navbar-icon far fa-bell"></i>
                                Notification
                            </a>

                            <!-- Header Notification  -->
                            <div class="header__notify">
                                <header class="header__notify-header">
                                    <h3>Lastest</h3>
                                </header>
                                <ul class="header__notify-list">
                                    <li class="header__notify-item header__notify-item--viewed">
                                        <a href="" class="header__notify-link">
                                            <img src="https://www.vietskin.vn/wp-content/uploads/2020/08/image-skincare-9.jpg"
                                                alt="" class="header__notify-img">
                                            <div class="header__notify-info">
                                                <span class="header__notify-name">not1</span>
                                                <span class="header__notify-description">not2</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="header__notify-item">
                                        <a href="" class="header__notify-link">
                                            <img src="https://luanvanviet.com/wp-content/uploads/2020/08/hinh-anh-san-pham-la-gi-4.jpg"
                                                alt="" class="header__notify-img">
                                            <div class="header__notify-info">
                                                <span class="header__notify-name">not3</span>
                                                <span class="header__notify-description">not4</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="header__notify-item">
                                        <a href="" class="header__notify-link">
                                            <img src="http://d20aeo683mqd6t.cloudfront.net/vi/articles/title_images/000/040/760/medium/Hadalabo-5822.jpg?2021"
                                                alt="" class="header__notify-img">
                                            <div class="header__notify-info">
                                                <span class="header__notify-name">not5</span>
                                                <span class="header__notify-description">not 6</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="header__notify-item">
                                        <a href="" class="header__notify-link">
                                            <img src="https://www.thmilk.vn/wp-content/uploads/2021/03/RICE_464x297.jpg"
                                                alt="" class="header__notify-img">
                                            <div class="header__notify-info">
                                                <span class="header__notify-name">not7</span>
                                                <span class="header__notify-description">not8</span>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                                <footer class="header__notify-footer">
                                    <a href="#" class="header__notify-footer-btn">
                                        See all
                                    </a>
                                </footer>
                            </div>
                        </li>
                        <li class="header__navbar-item">
                            <a href="#" class="header__navbar-item-link">
                                <i class="header__navbar-icon far fa-circle-question"></i>
                                Help
                            </a>
                        </li>
                        <!-- <li class="header__navbar-item header__navbar-item--bold header__navbar-item--separate">
                            Đăng ký
                        </li>
                        <li class="header__navbar-item header__navbar-item--bold">
                            Đăng nhập
                        </li> -->
                        <li class="header__navbar-item header__navbar-user">
                            <img src="https://i.pinimg.com/736x/13/2e/a7/132ea72d2bc3b85d90409c9e8f2d0f4a.jpg" alt=""
                                class="header__navbar-user-img">
                            <span class="header__navbar-user-name">Hoang Hai Phong </span>

                            <ul class="header__navbar-user-menu">
                                <li class="header__navbar-user-item">
                                    <a href="">My account</a>
                                </li>
                                <li class="header__navbar-user-item">
                                    <a href="">My address</a>
                                </li>
                                <li class="header__navbar-user-item">
                                    <a href="">Orders</a>
                                </li>
                                <li class="header__navbar-user-item header__navbar-user-item--separate">
                                    <a href="Selectrole.jsp">Logout</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>

                <!-- Header with search -->
                <div class="header-with-search">
                    <label for="mobile-search-checkbox" class="header__mobile-search">
                        <i class="header__mobile-search-icon fa-solid fa-magnifying-glass"></i>
                    </label>

                    <div class="header__logo hide-on-tablet">
                        <a href="./" class="header__logo-link">
                            
                        </a>
                    </div>

                    <input type="checkbox" hidden id="mobile-search-checkbox" class="mobile-search-checkbox">

                    <div class="header__search">
                        <div class="header__search-input-wrap">
                            <!-- Header search input -->
                            <input type="text" class="header__search-input" placeholder="Search">

                            <!-- History search box -->
                            <div class="header__search-history">
                                <h3 class="header__search-history-heading">Search History</h3>
                                <ul class="header__search-history-list">
                                    <li class="header__search-history-item">
                                        <a href="#">
                                            Wine1
                                            <img src="https://cf.shopee.vn/file/491389dce9eabc3510a3e8a21cc40ef7"
                                                alt="Sale">
                                        </a>
                                    </li>
                                    <li class="header__search-history-item">
                                        <a href="#">Wine2</a>
                                    </li>
                                    <li class="header__search-history-item">
                                        <a href="#">Wine3</a>
                                    </li>
                                    <li class="header__search-history-item">
                                        <a href="#">Wine4</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="header__search-select">
                            <span class="header__search-select-label">
                                In shop
                                <i class="header__search-select-icon fa-solid fa-angle-down"></i>
                            </span>

                            <!-- Search option box -->
                            <ul class="header__search-option">
                                <li class="header__search-option-item header__search-option-item--active">
                                    <span>In shop</span>
                                    <i class="fa-solid fa-check"></i>
                                </li>
                                <li class="header__search-option-item">
                                    <span>Out shop</span>
                                    <i class="fa-solid fa-check"></i>
                                </li>
                            </ul>
                        </div>
                        <button class="header__search-btn">
                            <i class="header__search-btn-icon fa-solid fa-magnifying-glass"></i>
                        </button>

                        <!-- Header search suggest -->
                        <ul class="header__search-suggest-list hide-on-mobile-tablet">
                            <li class="header__search-suggest-list-item">
                                <a href="gin.jsp" class="header__search-suggest-link">Gin</a>
                            </li>
                            <li class="header__search-suggest-list-item">
                                <a href="champange.jsp" class="header__search-suggest-link">Champange</a>
                            </li>
                            <li class="header__search-suggest-list-item">
                                <a href="vodka.jsp" class="header__search-suggest-link">Vodka</a>
                            </li>
                            <li class="header__search-suggest-list-item">
                                <a href="rum.jsp" class="header__search-suggest-link">Rum</a>
                            </li>
                            
                        </ul>
                    </div>

                    <!-- Cart layout -->
                    <div class="header__cart">
                        <div class="header__cart-wrap">
                            <i class="header__cart-icon fa-solid fa-cart-shopping"></i>

                            <span class="header__cart-notice">0</span>

                            <!-- No cart: header__cart-list--no-cart -->
                            <div class="header__cart-list">
                                <img src="./assets/img/no_cart.png" alt="No cart" class="header__cart-no-cart-img">
                                <span class="header__cart-no-cart-msg">Chưa có sản phẩm</span>

                                <h4 class="header__cart-heading">Added products</h4>
                                <ul class="header__cart-list-item">
                                    <!-- Cart item -->
                                    <li class="header__cart-item">
                                        <img src="https://i.pinimg.com/236x/6a/34/6e/6a346e457096f37d5f0e21e8dda68b44.jpg"
                                            alt="" class="header__cart-img">
                                        <div class="header__cart-item-info">
                                            <div class="header__cart-item-head">
                                                <h5 class="header__cart-item-name">Red Wine Spirito</h5>
                                                <div class="divheader__cart-item-price-wrap">
                                                    <span class="header__cart-item-price">$100</span>
                                                    <span class="header__cart-item-multiply">x</span>
                                                    <span class="header__cart-item-qnt">2</span>
                                                </div>
                                            </div>
                                            <div class="header__cart-item-body">
                                                <span class="header__cart-item-description">
                                                    Gin
                                                </span>
                                                <span class="header__cart-item-remove">
                                                    Delete
                                                </span>
                                            </div>
                                        </div>
                                    </li>

                                    <!-- Cart item -->
                                    <li class="header__cart-item">
                                        <img src="https://i.pinimg.com/236x/95/18/99/9518992922e3271ac94d7320699d87ef.jpg"
                                            alt="" class="header__cart-img">
                                        <div class="header__cart-item-info">
                                            <div class="header__cart-item-head">
                                                <h5 class="header__cart-item-name">
                                                    
												Rose Wine VinoVerse </h5>
                                                <div class="divheader__cart-item-price-wrap">
                                                    <span class="header__cart-item-price">$75</span>
                                                    <span class="header__cart-item-multiply">x</span>
                                                    <span class="header__cart-item-qnt">1</span>
                                                </div>
                                            </div>
                                            <div class="header__cart-item-body">
                                                <span class="header__cart-item-description">
                                                    Gin
                                                </span>
                                                <span class="header__cart-item-remove">
                                                    Delete
                                                </span>
                                            </div>
                                        </div>
                                    </li>

                                    <!-- Cart item -->
                                    <li class="header__cart-item">
                                        <img src="https://i.pinimg.com/236x/b5/57/d3/b557d34648f8eb087965fe56b177f3f4.jpg"
                                            alt="" class="header__cart-img">
                                        <div class="header__cart-item-info">
                                            <div class="header__cart-item-head">
                                                <h5 class="header__cart-item-name">
                                                    Champagne WineCraft
                                                </h5>
                                                <div class="divheader__cart-item-price-wrap">
                                                    <span class="header__cart-item-price">$180</span>
                                                    <span class="header__cart-item-multiply">x</span>
                                                    <span class="header__cart-item-qnt">1</span>
                                                </div>
                                            </div>
                                            <div class="header__cart-item-body">
                                                <span class="header__cart-item-description">
                                                    Gin
                                                </span>
                                                <span class="header__cart-item-remove">
                                                    Delete
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>

                                <a href="#" class="header__cart-view-cart btn btn--primary">Pay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <ul class="header__sort-bar">
                <li class="header__sort-item">
                    <a href="" class="header__sort-link">Related</a>
                </li>
                <li class="header__sort-item header__sort-item--active">
                    <a href="" class="header__sort-link">Latest</a>
                </li>
                <li class="header__sort-item">
                    <a href="" class="header__sort-link">Selling</a>
                </li>
                <li class="header__sort-item">
                    <a href="" class="header__sort-link">Price</a>
                </li>
            </ul>
        </header>
             </div>
 