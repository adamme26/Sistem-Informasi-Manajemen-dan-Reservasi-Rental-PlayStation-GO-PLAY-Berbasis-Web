const Jimp = require('jimp');

async function makeTransparent(inputFile, outputFile) {
    try {
        const image = await Jimp.read(inputFile);
        const width = image.bitmap.width;
        const height = image.bitmap.height;

        const threshold = 230;

        for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                const hex = image.getPixelColor(x, y);
                const rgb = Jimp.intToRGBA(hex);
                
                if (rgb.r > threshold && rgb.g > threshold && rgb.b > threshold) {
                    image.setPixelColor(Jimp.rgbaToInt(rgb.r, rgb.g, rgb.b, 0), x, y);
                }
            }
        }

        await image.writeAsync(outputFile);
        console.log(`Processed ${inputFile}`);
    } catch (err) {
        console.error(err);
    }
}

async function main() {
    await makeTransparent('public/images/ps4.png', 'public/images/ps4_trans.png');
    await makeTransparent('public/images/ps5.png', 'public/images/ps5_trans.png');
}

main();
