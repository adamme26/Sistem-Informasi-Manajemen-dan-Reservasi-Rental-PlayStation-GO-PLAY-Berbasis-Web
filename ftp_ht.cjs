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

        const htaccessContent = `<IfModule mod_rewrite.c>
    <IfModule mod_negotiation.c>
        Options -MultiViews -Indexes
    </IfModule>

    RewriteEngine On

    RewriteCond %{REQUEST_URI} !^/public/
    RewriteRule ^(.*)$ /public/$1 [L,QSA]
</IfModule>`;
        fs.writeFileSync(".htaccess_local2", htaccessContent);
        await client.uploadFrom(".htaccess_local2", ".htaccess");
        console.log("Uploaded NEW .htaccess");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
