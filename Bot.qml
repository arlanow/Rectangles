import QtQuick 2.0

Item {
    property int maybeNextStep: 0
    function tryBotStep() {

    }

    function turn() {
//        for (var i=0; i<main.fieldModel.length; i++)
//            if (main.fieldModel[i]==='2') {
//                maybeNextStep = i
//                break
//            }
        var success = false

//        for (var k=0; k<=main.fieldModel.length; k++) {
//            var nsy = Math.floor(k/main.fieldWidth)
//            var nsx = k-mnsy*main.fieldWidth
//            if (nsy<0) nsy = 0
//            if (nsx<0) nsx = 0
//            for (i=nsy; i<=main.fieldHeight; i++) {
//                for (var j=nsx; j<=main.fieldWidth; j++) {
//                    if (tryStep(j, i)) {
//                        success = true
//                        break
//                    }
//                    if (success) break
//                }
//            }
//            if (success) break
//        }
//        nextStep()
        for (var i=0; i<=gameScreen.fieldRows; i++) {
            for (var j=0; j<=gameScreen.fieldColumns; j++) {
                if (game.tryStep(j,i)) {
                    success = true
                }
                if (!success) {
                    if (game.tryStep(j,i, game.turnWidth, game.turnHeight)) {
                        success = true
                    }
                }
                if (success) break;
            }
            if (success) break;
        }
        console.log(success)
        if (success) game.nextStep(); else game.skip()
    }
}
