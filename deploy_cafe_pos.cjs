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
        
        // Ensure cafe-pos directory exists
        await client.ensureDir("cafe-pos");
        await client.clearWorkingDir();
        
        console.log("Uploading Cafe POS build to public_html/cafe-pos...");
        const distPath = path.join(__dirname, "..", "cafe-pos", "dist");
        await client.uploadFromDir(distPath);
        
        console.log("Deployed Cafe POS successfully.");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
