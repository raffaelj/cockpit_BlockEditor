<?php

$this->on('admin.init', function() {

    $this->helper('admin')->addAssets([
        'blockeditor:assets/css/style.min.css',

        'blockeditor:assets/components/field-layout.tag',
        'blockeditor:assets/components/field-layout-grid.tag',

        'blockeditor:assets/components/block-heading.tag',
        'blockeditor:assets/components/block-image.tag',
        'blockeditor:assets/components/block-text.tag',
        'blockeditor:assets/components/block-divider.tag',
        'blockeditor:assets/components/block-button.tag',
        'blockeditor:assets/components/block-html.tag',
    ]);

});
