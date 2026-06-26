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
        await client.downloadTo("live_env3.txt", "public_html/.env");
        console.log("Download complete.");
        
        // Read content
        let envContent = fs.readFileSync("live_env3.txt", "utf8");
        
        // Replace Google Client ID and Secret if they exist, or append if not
        if (envContent.includes("GOOGLE_CLIENT_ID")) {
            envContent = envContent.replace(/GOOGLE_CLIENT_ID=.*(\r?\n)/, 'GOOGLE_CLIENT_ID="1071049183357-o1d571i7r0e6fk3q2nje9f381d77c97h.apps.googleusercontent.com"$1');
            envContent = envContent.replace(/GOOGLE_CLIENT_SECRET=.*(\r?\n)/, 'GOOGLE_CLIENT_SECRET="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"$1');
        } else {
            envContent += "\nGOOGLE_CLIENT_ID=\"1071049183357-o1d571i7r0e6fk3q2nje9f381d77c97h.apps.googleusercontent.com\"\n";
            envContent += "GOOGLE_CLIENT_SECRET=\"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\"\n";
            envContent += "GOOGLE_REDIRECT_URI=\"https://portofolio-noval.my.id/auth/google/callback\"\n";
        }
        
        fs.writeFileSync("live_env3.txt", envContent);
        console.log("Keys replaced. Uploading back...");
        
        await client.uploadFrom("live_env3.txt", "public_html/.env");
        console.log("Upload complete.");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
