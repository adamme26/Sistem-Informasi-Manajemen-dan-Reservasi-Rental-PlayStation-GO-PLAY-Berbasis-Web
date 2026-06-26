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
        await client.downloadTo("live_env.txt", "public_html/.env");
        console.log("Download complete.");
        
        // Append Google keys
        let envContent = fs.readFileSync("live_env.txt", "utf8");
        
        // Check if GOOGLE_CLIENT_ID already exists
        if (!envContent.includes("GOOGLE_CLIENT_ID")) {
            envContent += "\n\n# Socialite Configuration\n";
            envContent += "GOOGLE_CLIENT_ID=\"1071049183357-o1d571i7r0e6fk3q2nje9f381d77c97h.apps.googleusercontent.com\"\n";
            envContent += "GOOGLE_CLIENT_SECRET=\"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\"\n";
            envContent += "GOOGLE_REDIRECT_URI=\"https://portofolio-noval.my.id/auth/google/callback\"\n";
            
            fs.writeFileSync("live_env.txt", envContent);
            console.log("Keys appended. Uploading back...");
            
            await client.uploadFrom("live_env.txt", "public_html/.env");
            console.log("Upload complete.");
        } else {
            console.log("Keys already exist in .env");
        }
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
