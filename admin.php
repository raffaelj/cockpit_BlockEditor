<?php

$this->on('admin.init', function() {

    $this->helper('admin')->addAssets([
        'layoutfieldadvanced:assets/css/style.min.css',

        'layoutfieldadvanced:assets/components/field-layout.tag',
        'layoutfieldadvanced:assets/components/field-layout-grid.tag',
//         'layoutfieldadvanced:assets/components/layout-field-heading.tag',
//         'layoutfieldadvanced:assets/components/layout-field-image.tag',
//         'layoutfieldadvanced:assets/components/layout-field-text.tag',
    ]);

});
