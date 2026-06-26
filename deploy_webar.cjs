const ftp = require("basic-ftp");
const path = require("path");

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
        
        await client.cd("public_html");
        
        // Upload updated projects.html
        await client.uploadFrom(path.join(__dirname, "projects.html"), "projects.html");
        console.log("Deployed projects.html to public_html.");

        // Create webar directory if it doesn't exist
        await client.ensureDir("webar");
        
        // Upload webar files
        const webarDir = path.join(__dirname, "..", "webar-particles");
        await client.uploadFromDir(webarDir);
        console.log("Deployed webar files to public_html/webar.");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
