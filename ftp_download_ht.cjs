const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
            secure: false
        });
        
        await client.downloadTo("htaccess_server.txt", "public_html/.htaccess");
        console.log("Downloaded .htaccess");
    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
