const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading BookingStatusNotification.php...");
        await client.uploadFrom(
            "app/Notifications/BookingStatusNotification.php", 
            "goplay_backend/app/Notifications/BookingStatusNotification.php"
        );
        
        console.log("Uploading BookingAdminController.php...");
        await client.uploadFrom(
            "app/Http/Controllers/Admin/BookingAdminController.php", 
            "goplay_backend/app/Http/Controllers/Admin/BookingAdminController.php"
        );
        
        console.log("Done updating notifications on live server!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
