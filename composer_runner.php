<?php
try {
    echo "<pre>";
    echo "Running composer install...\n";
    // run composer install in the parent directory (public_html)
    putenv('COMPOSER_HOME=' . __DIR__ . '/../.composer');
    chdir(__DIR__ . '/..'); // go to public_html
    $output = shell_exec('composer install --no-dev --optimize-autoloader 2>&1');
    echo htmlspecialchars($output);
    echo "</pre>";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
