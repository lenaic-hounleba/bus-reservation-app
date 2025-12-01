




<section aria-label="section">
    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <h2 class="text-center fw-bold mb-4"><?php echo $titre; ?></h2>
                
                <!-- <p class="text-center mb-4">Créer un compte pour un invité.</p> -->
                
                <?= session()->getFlashdata('error') ?>
               
                <!-- Formulaire de création de compte -->
                <?php echo form_open('/compte/creer', ['id' => 'account_create_form', 'class' => 'form-border']); ?>

                <?= csrf_field() ?>

                <div class="row">
                    <div class="col-md-6">
                        <div class="field-set">
                            <label for="pseudo">Pseudo :</label>
                            <input type="text" name="pseudo" id="pseudo" class="form-control" >
                            <?= validation_show_error('pseudo') ?>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="field-set">
                            <label for="mdp">Mot de passe :</label>
                            <input type="password" name="mdp" id="mdp" class="form-control" >
                            <?= validation_show_error('mdp') ?>
                        </div>
                    </div>

                    <div class="col-md-12 text-center">
                        <div id='submit' class="pull-center" style="margin-top: 30px;">
                            <input type="submit" name="submit" value="Créer un nouveau compte" class="btn-main color-2">
                        </div>
                    </div>
                </div>

                <?php echo form_close(); ?>

                <!-- Messages de succès ou d'erreur -->
                <div id="mail_success" class="success mt-3" style="display: none;">Votre compte a été créé avec succès.</div>
                <div id="mail_fail" class="error mt-3" style="display: none;">Désolé, une erreur s'est produite lors de la création de votre compte.</div>
            </div>
        </div>
    </div>
</section>



<!-- Back to top button -->
<a href="#" id="back-to-top" style="display: none;">Back to Top</a>
