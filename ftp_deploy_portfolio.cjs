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
        
        await client.cd("public_html");
        await client.uploadFrom("index.html", "index.html");
        await client.uploadFrom("projects.html", "projects.html");
        console.log("Deployed index.html and projects.html to public_html.");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
