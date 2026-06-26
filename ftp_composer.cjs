const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading composer files...");
        // upload composer.json to public_html so that composer install runs there
        await client.uploadFrom("composer.json", "public_html/composer.json");
        await client.uploadFrom("composer.lock", "public_html/composer.lock");
        
        console.log("Creating composer_runner.php...");
        const runnerContent = `<?php
try {
    echo "<pre>";
    echo "Running composer install...\\n";
    // run composer install in the parent directory (public_html)
    putenv('COMPOSER_HOME=' . __DIR__ . '/../.composer');
    chdir(__DIR__ . '/..'); // go to public_html
    $output = shell_exec('composer install --no-dev --optimize-autoloader 2>&1');
    echo htmlspecialchars($output);
    echo "</pre>";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
`;
        require('fs').writeFileSync("composer_runner.php", runnerContent);
        
        console.log("Uploading composer_runner.php to public_html/public...");
        await client.uploadFrom("composer_runner.php", "public_html/public/composer_runner.php");
        
        console.log("Upload complete.");
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
