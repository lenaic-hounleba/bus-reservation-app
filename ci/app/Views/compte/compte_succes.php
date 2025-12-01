




















<section aria-label="confirmation-section">
    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="confirmation-box">
                    <h2 class="text-center fw-bold mb-4">Bravo ! Formulaire rempli, le compte suivant a été ajouté :</h2>

                    <div class="confirmation-details">
                        <p class="confirmation-text"><strong>Pseudo:</strong> <?php echo $le_compte; ?></p>
                        <p class="confirmation-text"><strong><?php echo $le_message; ?></strong> <?php echo $le_total; ?></p>
                        
                    </div>
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
