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
        
        await client.cd("/goplay_backend/database/migrations");
        await client.uploadFrom("database/migrations/2026_06_05_141325_add_started_at_to_bookings_safe.php", "2026_06_05_141325_add_started_at_to_bookings_safe.php");
        console.log("Uploaded migration file.");

        await client.cd("/public_html");
        await client.uploadFrom("migrate_runner.php", "migrate_runner.php");
        console.log("Uploaded migrate_runner.php.");

        console.log("FTP upload complete!");
    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
