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








































<div class="container mt-4">
    <h2 class="mb-4"><?= esc($titre) ?></h2>

    

    <?= form_open('membre/reservations') ?>

    <div class="mb-3">
        <label class="form-label">Choisissez une date :</label>
        <input type="date" name="date_resa" class="form-control" value="<?= set_value('date_resa') ?>">
        <?= validation_list_errors() ?>
    </div>

    <button class="btn btn-primary">Voir les réservations</button>

    </form>
</div>
