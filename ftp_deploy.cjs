const ftp = require("basic-ftp");
const fs = require("fs");

async function main() {
    const client = new ftp.Client();
    client.ftp.verbose = true;
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
            secure: false
        });
        
        console.log("Connected to FTP!");
        await client.cd("public_html");
        
        // Delete default index.php
        try {
            await client.remove("index.php");
            console.log("Deleted index.php");
        } catch (e) {
            console.log("No index.php found or error deleting.");
        }
        
        // Delete default.php
        try {
            await client.remove("default.php");
            console.log("Deleted default.php");
        } catch (e) {
            console.log("No default.php found or error deleting.");
        }

        // Upload .htaccess
        const htaccessContent = `<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^(.*)$ public/$1 [L]
</IfModule>`;
        fs.writeFileSync(".htaccess_local", htaccessContent);
        await client.uploadFrom(".htaccess_local", ".htaccess");
        console.log("Uploaded .htaccess");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
