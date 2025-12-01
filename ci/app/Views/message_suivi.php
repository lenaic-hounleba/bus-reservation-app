<section id="section-hero" aria-label="section" class="jarallax">
                <img src="<?php echo base_url();?>bootstrap/images/background/1.jpg" class="jarallax-img" alt="">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12 text-light">
                            <div class="spacer-double"></div>
                            <div class="spacer-double"></div>
                            <h1 class="mb-2">Looking for a <span class="id-color">vehicle</span>? You're at the right place.</h1>
                            <div class="spacer-single"></div>
                        </div>

                        <div class="col-lg-12">
                            <div class="spacer-single sm-hide"></div>
                            <div class="p-4 rounded-3 shadow-soft" data-bgcolor="#ffffff">
                                

                                <form name="contactForm" id='contact_form' method="post">
                                    <div id="step-1" class="row">
                                        <div class="col-lg-6 mb30">
                                            <h5>What is your vehicle type?</h5>

                                            <div class="de_form de_radio row g-3">
                                                <div class="radio-img col-lg-3 col-sm-3 col-6">
                                                    <input id="radio-1a" name="Car_Type" type="radio" value="Residential" checked="checked">
                                                    <label for="radio-1a"><img src="<?php echo base_url();?>bootstrap/images/select-form/car.png" alt="">Car</label>
                                                </div>

                                                <div class="radio-img col-lg-3 col-sm-3 col-6">
                                                    <input id="radio-1b" name="Car_Type" type="radio" value="Office">
                                                    <label for="radio-1b"><img src="<?php echo base_url();?>bootstrap/images/select-form/van.png" alt="">Van</label>
                                                </div>

                                                <div class="radio-img col-lg-3 col-sm-3 col-6">
                                                    <input id="radio-1c" name="Car_Type" type="radio" value="Commercial">
                                                    <label for="radio-1c"><img src="<?php echo base_url();?>bootstrap/images/select-form/minibus.png" alt="">Minibus</label>
                                                </div>

                                                <div class="radio-img col-lg-3 col-sm-3 col-6">
                                                    <input id="radio-1d" name="Car_Type" type="radio" value="Retail">
                                                    <label for="radio-1d"><img src="<?php echo base_url();?>bootstrap/images/select-form/sportscar.png" alt="">Prestige</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="row">
                                                <div class="col-lg-6 mb20">
                                                    <h5>Pick Up Location</h5>
                                                    <input type="text" name="PickupLocation" onfocus="geolocate()" placeholder="Enter your pickup location" id="autocomplete" autocomplete="off" class="form-control">

                                                    <div class="jls-address-preview jls-address-preview--hidden">
                                                        <div class="jls-address-preview__header">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 mb20">
                                                    <h5>Drop Off Location</h5>
                                                    <input type="text" name="DropoffLocation" onfocus="geolocate()" placeholder="Enter your dropoff location" id="autocomplete2" autocomplete="off" class="form-control">

                                                    <div class="jls-address-preview jls-address-preview--hidden">
                                                        <div class="jls-address-preview__header">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 mb20">
                                                    <h5>Pick Up Date & Time</h5>
                                                    <div class="date-time-field">
                                                        <input type="text" id="date-picker" name="Pick Up Date" value="">
                                                        <select name="Pick Up Time" id="pickup-time">
                                                            <option selected disabled value="Select time">Time</option>
                                                            <option value="00:00">00:00</option>
                                                            <option value="00:30">00:30</option>
                                                            <option value="01:00">01:00</option>
                                                            <option value="01:30">01:30</option>
                                                            <option value="02:00">02:00</option>
                                                            <option value="02:30">02:30</option>
                                                            <option value="03:00">03:00</option>
                                                            <option value="03:30">03:30</option>
                                                            <option value="04:00">04:00</option>
                                                            <option value="04:30">04:30</option>
                                                            <option value="05:00">05:00</option>
                                                            <option value="05:30">05:30</option>
                                                            <option value="06:00">06:00</option>
                                                            <option value="06:30">06:30</option>
                                                            <option value="07:00">07:00</option>
                                                            <option value="07:30">07:30</option>
                                                            <option value="08:00">08:00</option>
                                                            <option value="08:30">08:30</option>
                                                            <option value="09:00">09:00</option>
                                                            <option value="09:30">09:30</option>
                                                            <option value="10:00">10:00</option>
                                                            <option value="10:30">10:30</option>
                                                            <option value="11:00">11:00</option>
                                                            <option value="11:30">11:30</option>
                                                            <option value="12:00">12:00</option>
                                                            <option value="12:30">12:30</option>
                                                            <option value="13:00">13:00</option>
                                                            <option value="13:30">13:30</option>
                                                            <option value="14:00">14:00</option>
                                                            <option value="14:30">14:30</option>
                                                            <option value="15:00">15:00</option>
                                                            <option value="15:30">15:30</option>
                                                            <option value="16:00">16:00</option>
                                                            <option value="16:30">16:30</option>
                                                            <option value="17:00">17:00</option>
                                                            <option value="17:30">17:30</option>
                                                            <option value="18:00">18:00</option>
                                                            <option value="18:30">18:30</option>
                                                            <option value="19:00">19:00</option>
                                                            <option value="19:30">19:30</option>
                                                            <option value="20:00">20:00</option>
                                                            <option value="20:30">20:30</option>
                                                            <option value="21:00">21:00</option>
                                                            <option value="21:30">21:30</option>
                                                            <option value="22:00">22:00</option>
                                                            <option value="22:30">22:30</option>
                                                            <option value="23:00">23:00</option>
                                                            <option value="23:30">23:30</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 mb20">
                                                    <h5>Return Date & Time</h5>
                                                    <div class="date-time-field">
                                                        <input type="text" id="date-picker-2" name="Collection Date" value="">
                                                        <select name="Collection Time" id="collection-time">
                                                            <option selected disabled value="Select time">Time</option>
                                                            <option value="00:00">00:00</option>
                                                            <option value="00:30">00:30</option>
                                                            <option value="01:00">01:00</option>
                                                            <option value="01:30">01:30</option>
                                                            <option value="02:00">02:00</option>
                                                            <option value="02:30">02:30</option>
                                                            <option value="03:00">03:00</option>
                                                            <option value="03:30">03:30</option>
                                                            <option value="04:00">04:00</option>
                                                            <option value="04:30">04:30</option>
                                                            <option value="05:00">05:00</option>
                                                            <option value="05:30">05:30</option>
                                                            <option value="06:00">06:00</option>
                                                            <option value="06:30">06:30</option>
                                                            <option value="07:00">07:00</option>
                                                            <option value="07:30">07:30</option>
                                                            <option value="08:00">08:00</option>
                                                            <option value="08:30">08:30</option>
                                                            <option value="09:00">09:00</option>
                                                            <option value="09:30">09:30</option>
                                                            <option value="10:00">10:00</option>
                                                            <option value="10:30">10:30</option>
                                                            <option value="11:00">11:00</option>
                                                            <option value="11:30">11:30</option>
                                                            <option value="12:00">12:00</option>
                                                            <option value="12:30">12:30</option>
                                                            <option value="13:00">13:00</option>
                                                            <option value="13:30">13:30</option>
                                                            <option value="14:00">14:00</option>
                                                            <option value="14:30">14:30</option>
                                                            <option value="15:00">15:00</option>
                                                            <option value="15:30">15:30</option>
                                                            <option value="16:00">16:00</option>
                                                            <option value="16:30">16:30</option>
                                                            <option value="17:00">17:00</option>
                                                            <option value="17:30">17:30</option>
                                                            <option value="18:00">18:00</option>
                                                            <option value="18:30">18:30</option>
                                                            <option value="19:00">19:00</option>
                                                            <option value="19:30">19:30</option>
                                                            <option value="20:00">20:00</option>
                                                            <option value="20:30">20:30</option>
                                                            <option value="21:00">21:00</option>
                                                            <option value="21:30">21:30</option>
                                                            <option value="22:00">22:00</option>
                                                            <option value="22:30">22:30</option>
                                                            <option value="23:00">23:00</option>
                                                            <option value="23:30">23:30</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <input type='submit' id='send_message' value='Find a Vehicle' class="btn-main pull-right">
                                        </div>

                                    </div>
                                    
                                </form>
                            </div>
                        </div>

                        <div class="spacer-double"></div>

                        <div class="row">
                            <div class="col-lg-12 text-light">
                                <div class="container-timeline">
                                    <ul>
                                        <li>
                                            <h4>Choose a vehicle</h4>
                                            <p>Unlock unparalleled adventures and memorable journeys with our vast fleet of vehicles tailored to suit every need, taste, and destination.</p>
                                        </li>
                                        <li>
                                            <h4>Pick location &amp; date</h4>
                                            <p>Pick your ideal location and date, and let us take you on a journey filled with convenience, flexibility, and unforgettable experiences.</p>
                                        </li>
                                        <li>
                                            <h4>Make a booking</h4>
                                            <p>Secure your reservation with ease, unlocking a world of possibilities and embarking on your next adventure with confidence.</p>
                                        </li>
                                        <li>
                                            <h4>Sit back &amp; relax</h4>
                                            <p>Hassle-free convenience as we take care of every detail, allowing you to unwind and embrace a journey filled comfort.</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>









































<div class="container" style="margin-top: 50px; margin-bottom: 50px;">

    <style>
        :root {
            --accent: #1ECB15;
            --black: #000;
            --white: #fff;
            --shadow: rgba(0, 0, 0, 0.1);
            --gray-light: #f9f9f9;
            --gray-dark: #333;
        }

        .message-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .request-card {
            border: 1px solid #1ECB15;
            border-radius: 12px;
            box-shadow: 0px 4px 20px var(--shadow);
            background: var(--white);
            padding: 2rem;
        }

        .request-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 2px solid var(--gray-light);
            padding-bottom: 1rem;
        }

        .request-header .request-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--black);
        }

        .request-header .request-meta {
            color: rgba(0, 0, 0, 0.7);
            font-size: 1rem;
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Centre les éléments dans la ligne */
        }

        .request-meta span {
            margin-bottom: 10px;
        }

        .badge-accent {
            background: var(--accent);
            color: var(--white);
            border-radius: 0.5rem;
            padding: 0.35rem 0.55rem;
            font-weight: 600;
        }

        .message-body {
            text-align: left;
        }

        .message-body p {
            font-size: 1.1rem;
            color: black;
            /* margin-bottom: 1.5rem; */
        }

        .message-body strong {
            font-weight: 600;
            color: black;
        }

        .response-box {
            background: #e9f5ee;
            padding-bottom: 0px !important;
            padding: 20px;
            border-left: 5px solid var(--accent);
            margin-top: 10px;
            font-size: 1.1rem;
            border-radius: 8px; /* Rounded corners */
        }

        .no-response {
            color: #1ECB15;
            text-align: center;
            /* background-color: white; */
            font-style: italic;
            font-size: 1.2rem;
            margin-top: 30px;
        }

        .alert-warning {
            background: #f39c12;
            color: var(--white);
            padding: 15px;
            margin-top: 20px;
            text-align: center;
            border-radius: 8px;
        }

        @media (max-width: 576px) {
            .request-header {
                flex-direction: column;
                text-align: center;
            }

            .request-title {
                font-size: 1.8rem;
            }

            .message-body {
                font-size: 1rem;
            }

            .response-box {
                padding: 15px;
            }

            .badge-accent {
                margin-top: 15px;
            }

            .request-meta {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>

    <h1 class="text-center fw-bold mb-4 request-title">
        <?php echo $titre; ?>
    </h1>

    <?php if (!empty($demande)): ?>

    <div class="card request-card shadow-sm">
        <div class="request-header">
            <div class="request-meta">
                <span><strong>Envoyé le :</strong> <?php echo htmlspecialchars($demande->msg_date, ENT_QUOTES, 'UTF-8'); ?></span>
                <span style="margin-left: 30px;"><strong>Par :</strong> <?php echo htmlspecialchars($demande->msg_email, ENT_QUOTES, 'UTF-8'); ?></span>
            </div>
            <div class="badge-accent">Code : <?php echo htmlspecialchars($demande->msg_code, ENT_QUOTES, 'UTF-8'); ?></div>
        </div>

        <div class="message-body">
            <p><strong>Sujet :</strong> <?php echo htmlspecialchars($demande->msg_sujet, ENT_QUOTES, 'UTF-8'); ?></p>
            <p><strong>Contenu du message :</strong><br /><?php echo nl2br(htmlspecialchars($demande->msg_contenu, ENT_QUOTES, 'UTF-8')); ?></p>
        </div>

        <?php if (!empty($demande->msg_reponse)): ?>
            <div class="response-box">
                <p><strong>Réponse de l'administrateur :</strong><br /><?php echo nl2br(htmlspecialchars($demande->msg_reponse, ENT_QUOTES, 'UTF-8')); ?></p>
            </div>
        <?php else: ?>
            <div class="no-response">
                <p><i>Aucune réponse n'a encore été donnée.</i></p>
            </div>
        <?php endif; ?>

        <a href="<?php echo base_url('index.php/contact/ajouter'); ?>" class="btn-main" style="background:#444; width: 200px; margin: 50px auto 0 auto; display: block; text-align: center;"> Faire une demande </a>
    </div>

<?php else: ?>

    <div class="alert alert-warning text-center">
        <?php
        if (!empty($erreur)) {
            echo htmlspecialchars($erreur, ENT_QUOTES, 'UTF-8');
        } else {
            echo "Aucune demande disponible ou erreur inattendue.";
        }
        ?>
    </div>

<?php endif; ?>

</div>
