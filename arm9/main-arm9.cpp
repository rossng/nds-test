/*---------------------------------------------------------------------------------

	Simple console print demo
	-- dovoto

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

#include "init.hpp"

#include <example.hpp>
#include <starField.h>

static const int DMA_CHANNEL = 3;

int main(void)
{
    touchPosition touch;

    powerOn(POWER_ALL_2D);

    initVideo();
    initBackgrounds();

    dmaCopyHalfWords(DMA_CHANNEL,
                     starFieldBitmap, /* This variable is generated for us by
                                       * grit. */
                     (uint16 *)BG_BMP_RAM(0), /* Our address for main
                                               * background 3 */
                     starFieldBitmapLen); /* This length (in bytes) is generated
                                           * from grit. */

    consoleDemoInit();  //setup the sub screen for printing

    iprintf("\n\n\tHello DS dev'rs\n");
    iprintf("\twww.drunkencoders.com\n");
    iprintf("\twww.devkitpro.org");

    while (1) {

        touchRead(&touch);
        iprintf("\x1b[10;0HTouch x = %04i, %04i\n", touch.rawx, touch.px);
        iprintf("Touch y = %04i, %04i\n", touch.rawy, touch.py);

        swiWaitForVBlank();
        scanKeys();
        if (keysDown() & KEY_START) break;
    }

    return 0;
}
