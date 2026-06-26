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
        await client.downloadTo("../index.html", "index.html");
        await client.downloadTo("../projects.html", "projects.html");
        console.log("Downloaded index.html and projects.html to scratch folder.");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
