<!-- content begin -->
        <div class="no-bottom no-top" id="content">
            <div id="top"></div>
            
            <!-- section begin -->
            <section id="subheader" class="jarallax text-light">
                <img src="<?php echo base_url();?>bootstrap/images/background/subheader.jpg" class="jarallax-img" alt="">
                    <div class="center-y relative text-center">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 text-center">
									<h1>Nous contacter</h1>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
            </section>
<!-- section close -->













<section aria-label="confirmation-section">
    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-8 offset-md-2">

                <div class="confirmation-box">
                    <h2 class="text-center fw-bold mb-4">Votre message a été envoyé !</h2>

                    <div class="confirmation-details">
                        <p class="confirmation-text">
                            <strong>Sujet :</strong> <?php echo $le_sujet; ?>
                        </p>

                        <p class="confirmation-text">
                            <strong>Votre code de suivi :</strong><br><br>
                            <span style="font-size: 1.5rem; letter-spacing: 2px; color: #1ECB15;">
                                <i class="fa fa-exclamation-circle" style="color: black;"></i> <!-- icône "important" -->
                                <?php echo $le_code; ?>
                                <i class="fa fa-exclamation-circle" style="color: black;"></i> <!-- icône "important" -->
                            </span>
                        </p>

                        <p class="confirmation-text">
                            Conservez ce code pour suivre votre demande.
                        </p>

                        
                    </div>
                    <a href="<?php echo base_url('index.php/message/verifier'); ?>" class="btn-main" style="background:#444; width: 200px; margin: 50px auto 0 auto; display: block; text-align: center;"> Suivre une demande </a>
                </div>
                
            </div>
        </div>
    </div>
</section>

<style>
    .confirmation-box {
        background-color: white;
        padding: 3rem;
        border-radius: 12px;
        border: 1px solid #1ECB15;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .confirmation-box h3 {
        color: #1ECB15;
        font-size: 1.8rem;
    }

    .confirmation-details {
        background-color: #e9f5ee;
        border-left: 5px solid #1ECB15;
        padding: 20px;
        padding-bottom: 1px;
        margin-top: 20px;
        border-radius: 8px;
    }

    .confirmation-text {
        font-size: 1.1rem;
        color: #333;
    }
</style>