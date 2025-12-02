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
									<h1>Connexion</h1>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
            </section>
<!-- section close -->







































<h2><?php echo $titre; ?></h2>
<?php if (!empty($erreur)) : ?>
    <div class="alert alert-danger" style="margin-bottom: 20px;">
        <?= $erreur ?>
    </div>
<?php endif; ?>


<?= session()->getFlashdata('error') ?>

<?php echo form_open('/compte/connecter'); ?>
    <?= csrf_field() ?>
    <label for="pseudo">Pseudo : </label>
    <input type="input" name="pseudo" value="<?= set_value('pseudo') ?>">
    <?= validation_show_error('pseudo') ?>
    <label for="mdp">Mot de passe : </label>
    <input type="password" name="mdp">
    <?= validation_show_error('mdp') ?>
    <input type="submit" name="submit" value="Se connecter">
</form>