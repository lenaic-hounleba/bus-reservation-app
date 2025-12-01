<!-- MENU VISITEUR (PUBLIC) -->
<header class="transparent scroll-light has-topbar">
    <div id="topbar" class="topbar-dark text-light">
        <div class="container">
            <div class="topbar-left xs-hide">
                <div class="topbar-widget">
                    <div class="topbar-widget"><a href="#"><i class="fa fa-phone"></i> +33 7 45749822</div>
                    <div class="topbar-widget"><a href="#"><i class="fa fa-envelope"></i> lovehounleba@gmail.com</div>
                    <div class="topbar-widget"><a href="#"><i class="fa fa-clock-o"></i> Lundi - Vendredi 08h00 - 18h00</div>
                </div>
            </div>

            <div class="topbar-right">
                <div class="social-icons">
                    <a href="#"><i class="fa fa-facebook fa-lg"></i></a>
                    <a href="#"><i class="fa fa-twitter fa-lg"></i></a>
                    <a href="#"><i class="fa fa-instagram fa-lg"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- NAVIGATION -->
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="de-flex sm-pt10">

                    <!-- LOGO -->
                    <div class="de-flex-col">
                        <div id="logo">
                            <a href="<?php echo base_url(); ?>">
                                <img class="logo-1" src="<?php echo base_url();?>bootstrap/images/logo-light.png" alt="">
                                <img class="logo-2" src="<?php echo base_url();?>bootstrap/images/logo.png" alt="">
                            </a>
                        </div>
                    </div>

                    <!-- MENU -->
                    <div class="de-flex-col header-col-mid">
                        <ul id="mainmenu">
                            <li><a class="menu-item" href="<?php echo base_url(); ?>">Accueil</a></li>
                            <li><a class="menu-item" href="<?php echo base_url('index.php/contact/ajouter'); ?>">Nous contacter</a></li>
                            <li><a class="menu-item" href="<?php echo base_url('index.php/message/verifier'); ?>">Suivre une demande</a></li>
                        </ul>
                    </div>

                    <!-- BOUTON -->
                    <div class="de-flex-col">
                        <div class="menu_side_area">
                            <a href="<?php echo base_url('index.php/compte/connecter'); ?>" class="btn-main">Connexion</a>
                            <span id="menu-btn"></span>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</header>
























