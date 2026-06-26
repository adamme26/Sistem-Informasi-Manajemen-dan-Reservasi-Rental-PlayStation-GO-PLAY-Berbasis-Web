const ftp = require("basic-ftp");
const fs = require("fs");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Downloading .env from live server...");
        await client.downloadTo("live_env2.txt", "public_html/.env");
        console.log("Download complete.");
        
        // Append Facebook keys
        let envContent = fs.readFileSync("live_env2.txt", "utf8");
        
        // Check if FACEBOOK_CLIENT_ID already exists
        if (!envContent.includes("FACEBOOK_CLIENT_ID")) {
            envContent += "\nFACEBOOK_CLIENT_ID=\"836368069192529\"\n";
            envContent += "FACEBOOK_CLIENT_SECRET=\"7c50a2a3487c1a14307bf477bb745954\"\n";
            envContent += "FACEBOOK_REDIRECT_URI=\"https://portofolio-noval.my.id/auth/facebook/callback\"\n";
            
            fs.writeFileSync("live_env2.txt", envContent);
            console.log("Facebook keys appended. Uploading back...");
            
            await client.uploadFrom("live_env2.txt", "public_html/.env");
            console.log("Upload complete.");
        } else {
            console.log("Facebook keys already exist in .env");
        }
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
