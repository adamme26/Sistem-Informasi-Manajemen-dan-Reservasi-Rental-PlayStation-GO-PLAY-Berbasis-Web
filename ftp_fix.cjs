const ftp = require("basic-ftp");
const fs = require("fs");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
            secure: false
        });
        
        await client.cd("public_html");
        
        // Cek isi folder public
        await client.cd("public");
        const publicList = await client.list();
        console.log("Isi folder public:", publicList.map(f => f.name));
        
        // Hapus file index.php bawaan Domainesia di dalam folder public jika ada
        await client.remove("index.php").catch(()=>console.log("no index.php in public"));
        await client.remove("default.html").catch(()=>console.log("no default.html in public"));
        
        // Upload ulang index.php milik Laravel ke folder public
        const laravelIndex = `<?php

use Illuminate\\Http\\Request;

define('LARAVEL_START', microtime(true));

// Determine if the application is in maintenance mode...
if (file_exists($maintenance = __DIR__.'/../storage/framework/maintenance.php')) {
    require $maintenance;
}

// Register the Composer autoloader...
require __DIR__.'/../vendor/autoload.php';

// Bootstrap, and create the application...
$app = require_once __DIR__.'/../bootstrap/app.php';

// Handle the request...
$app->handleRequest(Request::capture());
`;
        fs.writeFileSync("index_laravel.php", laravelIndex);
        await client.uploadFrom("index_laravel.php", "index.php");
        console.log("Uploaded Laravel index.php to public/");
        
    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
