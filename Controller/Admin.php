<?php

// copy/paste from LayoutComponents addon

namespace BlockEditor\Controller;


class Admin extends \Cockpit\AuthController {

    public function index() {

        $content = '{}';

        if ($file = $this->app->path('#storage:components.json')) {
            $content = @file_get_contents($file);
        }

        $json = json_decode($content, true);

        if (!$json) {
            $json = [];
        }

        $components = new \ArrayObject($json);

        // changed path
        return $this->render('blockeditor:views/index.php', compact('components'));
    }

}
