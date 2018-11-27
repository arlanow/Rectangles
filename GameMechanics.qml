import QtQuick 2.0

QtObject {
    id: obj
    property int turnPointer: 2
    property string turnDescription: (turnPointer===1)?'Синий':'Оранжевый'
    property string mode: 'passes'
    property int turnCounter: 0
    property int skipped1: 0
    property int skipped2: 0
    onScore1Changed: {
        if (mode==='score' && score1>gameScreen.fieldRows*gameScreen.fieldColumns/2) end(1)
    }
    onScore2Changed: {
        if (mode==='score' && score2>gameScreen.fieldRows*gameScreen.fieldColumns/2) end(2)
    }
    property int turnWidth: 0
    property int turnHeight: 0
    property int score1: 0
    property int score2: 0
    property variant fieldModel: []
    property string highlightedColor: 'Green'
    property string endText
    property int rowWidth: gameScreen.rowSize
    property int rowHeight: gameScreen.rowSize

    function newGame() {
        turnCounter = 0
        turnPointer = 2
        skipped1 = 0
        skipped2 = 0
        score1 = 0
        score2 = 0
        fieldModel = []
        for (var i=0; i<gameScreen.fieldRows; i++)
            for (var j=0; j<gameScreen.fieldColumns; j++)
                fieldModel.push('')
        cleanHighLited()
        fieldModel[0] = '1'
        fieldModel[fieldModel.length-1] = '2'
        fieldModelChanged()
        nextStep()
    }

    function end(player) {
        endText = (player===1)?'Синий игрок победил!':'Оранжевый игрок победил!'
        endText += '\nНачать сначала?'
        endDialog.open()
    }

    function skip() {
        if (turnPointer===1) skipped1++
        if (turnPointer===2) skipped2++
        if (mode==='passes') {
            if (skipped1>2) end(2)
            if (skipped2>2) end(1)
        }
        nextStep()
    }

    function haveNeighbors(player, x, y) {
        var left = y*gameScreen.fieldColumns+x-1
        var right = y*gameScreen.fieldColumns+x+1
        var top = (y-1)*gameScreen.fieldColumns+x
        var bottom = (y+1)*gameScreen.fieldColumns+x
        if (x>0 && fieldModel[left] === player.toString()) return true
        if (x<(gameScreen.fieldColumns-1) && fieldModel[right] === player.toString()) return true
        if (y>0 && fieldModel[top] === player.toString()) return true
        if (y<(gameScreen.rows) && fieldModel[bottom] === player.toString()) return true
        return false
    }

    function canStandHere(player, x, y, height, width) {
        if (x+width>gameScreen.fieldColumns || y+height>gameScreen.fieldRows) return false
        var haveneighbors = false
        // Нет занятых клеток и есть хоть один сосед
        for (var i=y; i<y+height; i++) {
            for (var j=x; j<x+width; j++) {
                if (fieldModel[i*gameScreen.fieldColumns+j] !== '' && fieldModel[i*gameScreen.fieldColumns+j] !== 'highlighted') return false
                else if (haveNeighbors(player, j, i)) haveneighbors = true
            }
        }
        if (haveneighbors) return true; else return false
    }
    function standHere(player, x, y, height, width) {
        for (var i=y; i<y+height; i++) {
            for (var j=x; j<x+width; j++) {
                fieldModel[i*gameScreen.fieldColumns+j] = player.toString()
            }
        }
        fieldModelChanged()
    }

    function tryStep(x,y, height, width) {
        if (height===undefined) height = turnHeight
        if (width===undefined) width = turnWidth
        if (canStandHere(turnPointer, x, y, height, width)) {
            standHere(turnPointer, x, y, height, width)
            if (turnPointer===1) score1+=height*width; else score2+=height*width
            if (turnPointer===1) skipped1 = 0
            if (turnPointer===2) skipped2 = 0
            return true
        }
        else return false
    }

    function nextStep() {
        turnPointer = 3 - turnPointer
        turnCounter++
        turnWidth = Math.ceil(Math.random()*6)
        turnHeight = Math.ceil(Math.random()*6)
        if (turnPointer===2 && botActive) bot.turn()
    }
    function highLight(x, y, height, width) {
        cleanHighLited()
        if ((height===turnHeight && width===turnWidth) || (height===turnWidth && width===turnHeight)) {
            if (game.canStandHere(game.turnPointer, x, y, height, width)) game.highlightedColor = 'Green'
            else game.highlightedColor = 'Yellow'
        } else game.highlightedColor = 'Yellow'
        for (var i=y; i<y+height; i++) {
            for (var j=x; j<x+width; j++) {
                if (fieldModel[i*gameScreen.fieldColumns+j] === '') fieldModel[i*gameScreen.fieldColumns+j] = 'highlighted'; else highlightedColor = 'Red'
            }
        }
        fieldModelChanged()

    }
    function cleanHighLited() {
        for (var i=0; i<gameScreen.fieldRows; i++)
            for (var j=0; j<gameScreen.fieldColumns; j++)
                if (fieldModel[i*gameScreen.fieldColumns+j]==='highlighted') fieldModel[i*gameScreen.fieldColumns+j] = ''
        fieldModelChanged()
    }
}
