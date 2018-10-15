const synth = new Tone.PolySynth().toMaster();
const chord = ["C3", "E3", "G3", "B3"];

synth.volume.value = -8;

var matrix = new Array(17);
for (var i = 0; i < 17; i++) {
  matrix[i] = new Array(4);
}

var loop = new Tone.Sequence(function (time, col) {
  var column = matrix[col];
  var c = [];
  for (var i = 0; i < 4; i++) {
    if (column[i] === 1) {
      c.push(chord[i]);
    }
  }
  synth.triggerAttackRelease(c, "24n");
}, [...Array(17).keys()], "16n");

Tone.Transport.start();

loop.start();

function toggleRandom() {
  const x = getRandomInt(0, 16);
  const y = getRandomInt(0, 3);
  matrix[x][y] = inverse(matrix[x][y]);
}

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function inverse(i) {
  return i === 1 ? 0 : 1;
}

setInterval(toggleRandom, 225);
