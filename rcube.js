// Generated by CoffeeScript 1.12.3
(function() {
  var foo, mutate, objBlock, objCube, objFace;

  mutate = function(aBlocks) {
    var i, l, ref, tBlock;
    tBlock = aBlocks[0]();
    for (i = l = 1, ref = aBlocks.length; 1 <= ref ? l < ref : l > ref; i = 1 <= ref ? ++l : --l) {
      aBlocks[i - 1](aBlocks[i]());
    }
    aBlocks[aBlocks.length - 1](tBlock);
  };

  objBlock = (function() {
    function objBlock(Value) {
      this.Value = Value;
      return (function(_this) {
        return function(aValue) {
          if (aValue != null) {
            _this.Value = aValue;
          }
          return _this.Value;
        };
      })(this);
    }

    return objBlock;

  })();

  objFace = (function() {
    function objFace(ID, aArray) {
      var i, l;
      this.ID = ID;
      this.blocks = {};
      for (i = l = 0; l <= 8; i = ++l) {
        this.blocks[i] = new objBlock(aArray[i]);
      }
      this.sides = {
        0: [this.blocks[0], this.blocks[1], this.blocks[2]],
        1: [this.blocks[2], this.blocks[3], this.blocks[8]],
        2: [this.blocks[8], this.blocks[7], this.blocks[6]],
        3: [this.blocks[6], this.blocks[3], this.blocks[0]]
      };
      return this;
    }

    objFace.prototype.rotateC = function() {
      var b;
      b = this.blocks;
      mutate([b[6], b[8], b[2], b[0]]);
      mutate([b[3], b[7], b[5], b[1]]);
    };

    objFace.prototype.rotateCC = function() {
      var b;
      b = this.blocks;
      mutate([b[0], b[2], b[8], b[6]]);
      mutate([b[1], b[5], b[7], b[3]]);
    };

    return objFace;

  })();

  objCube = (function() {
    function objCube(argCube) {
      switch (toString.call(argCube)) {
        case '[object String]':
          pass;
          break;
        case '[object Array]':
          pass;
          break;
        case '[object Object]':
          pass;
          break;
        default:
          this.initCube();
      }
      return this;
    }

    objCube.prototype.initCube = function(aR, aL, aB, aD, aF, aU) {
      this.faces = {
        "R": new objFace("R", aR != null ? aR : Array(10).join("R")),
        "L": new objFace("L", aL != null ? aL : Array(10).join("L")),
        "B": new objFace("B", aB != null ? aB : Array(10).join("B")),
        "D": new objFace("D", aD != null ? aD : Array(10).join("D")),
        "F": new objFace("F", aF != null ? aF : Array(10).join("F")),
        "U": new objFace("U", aU != null ? aU : Array(10).join("U"))
      };
    };

    objCube.prototype.importString = function(argString) {
      var l, m, tArray, tCube, tOut, tSide;
      tArray = argString.split('');
      tOut = [];
      for (tSide = l = 0; l <= 5; tSide = ++l) {
        tOut.push([]);
        for (tCube = m = 0; m <= 8; tCube = ++m) {
          tOut[tSide].push(tArray.pop());
        }
        tOut[tSide].reverse();
      }
      return this.importArray(tOut.reverse());
    };

    objCube.prototype.exportString = function() {
      var i, j, l, len, len1, m, tArray, tOut;
      tArray = this.exportArray();
      tOut = [];
      for (l = 0, len = tArray.length; l < len; l++) {
        i = tArray[l];
        for (m = 0, len1 = i.length; m < len1; m++) {
          j = i[m];
          tOut.push(j);
        }
      }
      return tOut.join("");
    };

    objCube.prototype.importArray = function(arg) {
      return this.initCube(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]);
    };

    objCube.prototype.exportArray = function() {
      var block, k, tOut;
      tOut = [];
      tOut.push((function() {
        var ref, results;
        ref = this.faces["R"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      tOut.push((function() {
        var ref, results;
        ref = this.faces["L"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      tOut.push((function() {
        var ref, results;
        ref = this.faces["B"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      tOut.push((function() {
        var ref, results;
        ref = this.faces["D"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      tOut.push((function() {
        var ref, results;
        ref = this.faces["F"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      tOut.push((function() {
        var ref, results;
        ref = this.faces["U"].blocks;
        results = [];
        for (k in ref) {
          block = ref[k];
          results.push(block());
        }
        return results;
      }).call(this));
      return tOut;
    };

    objCube.prototype.print = function() {
      var B, D, F, L, R, U;
      R = this.faces["R"].blocks;
      L = this.faces["L"].blocks;
      B = this.faces["B"].blocks;
      D = this.faces["D"].blocks;
      F = this.faces["F"].blocks;
      U = this.faces["U"].blocks;
      console.log("~ ~ ~ " + (U[0]()) + " " + (U[1]()) + " " + (U[2]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log("~ ~ ~ " + (U[3]()) + " " + (U[4]()) + " " + (U[5]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log("~ ~ ~ " + (U[6]()) + " " + (U[7]()) + " " + (U[8]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log((L[0]()) + " " + (L[1]()) + " " + (L[2]()) + " " + (F[0]()) + " " + (F[1]()) + " " + (F[2]()) + " " + (R[0]()) + " " + (R[1]()) + " " + (R[2]()) + " " + (B[0]()) + " " + (B[1]()) + " " + (B[2]()) + " ");
      console.log((L[3]()) + " " + (L[4]()) + " " + (L[5]()) + " " + (F[3]()) + " " + (F[4]()) + " " + (F[5]()) + " " + (R[3]()) + " " + (R[4]()) + " " + (R[5]()) + " " + (B[3]()) + " " + (B[4]()) + " " + (B[5]()) + " ");
      console.log((L[6]()) + " " + (L[7]()) + " " + (L[8]()) + " " + (F[6]()) + " " + (F[7]()) + " " + (F[8]()) + " " + (R[6]()) + " " + (R[7]()) + " " + (R[8]()) + " " + (B[6]()) + " " + (B[7]()) + " " + (B[8]()) + " ");
      console.log("~ ~ ~ " + (D[0]()) + " " + (D[1]()) + " " + (D[2]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log("~ ~ ~ " + (D[3]()) + " " + (D[4]()) + " " + (D[5]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log("~ ~ ~ " + (D[6]()) + " " + (D[7]()) + " " + (D[8]()) + " ~ ~ ~ ~ ~ ~ ");
      console.log("");
    };

    objCube.prototype.shift = function(argMove) {
      var B, D, F, L, R, U;
      R = this.faces["R"].blocks;
      L = this.faces["L"].blocks;
      B = this.faces["B"].blocks;
      D = this.faces["D"].blocks;
      F = this.faces["F"].blocks;
      U = this.faces["U"].blocks;
      switch (argMove) {
        case "R":
          this.faces["R"].rotateC();
          mutate([F[8], D[8], B[0], U[8]]);
          mutate([F[5], D[5], B[3], U[5]]);
          mutate([F[2], D[2], B[6], U[2]]);
          return;
        case "Ri":
          this.faces["R"].rotateCC();
          mutate([U[8], B[0], D[8], F[8]]);
          mutate([U[5], B[3], D[5], F[5]]);
          mutate([U[2], B[6], D[2], F[2]]);
          return;
        case "L":
          this.faces["L"].rotateC();
          mutate([B[8], D[0], F[0], U[0]]);
          mutate([B[5], D[3], F[3], U[3]]);
          mutate([B[2], D[6], F[6], U[6]]);
          return;
        case "Li":
          this.faces["L"].rotateCC();
          mutate([U[0], F[0], D[0], B[8]]);
          mutate([U[3], F[3], D[3], B[5]]);
          mutate([U[6], F[6], D[6], B[2]]);
          return;
        case "B":
          this.faces["B"].rotateC();
          mutate([R[8], D[6], L[0], U[2]]);
          mutate([R[5], D[7], L[3], U[1]]);
          mutate([R[2], D[8], L[6], U[0]]);
          return;
        case "Bi":
          this.faces["B"].rotateCC();
          mutate([U[2], L[0], D[6], R[8]]);
          mutate([U[1], L[3], D[7], R[5]]);
          mutate([U[0], L[6], D[8], R[2]]);
          return;
        case "D":
          this.faces["D"].rotateC();
          mutate([L[6], B[6], R[6], F[6]]);
          mutate([L[7], B[7], R[7], F[7]]);
          mutate([L[8], B[8], R[8], F[8]]);
          return;
        case "Di":
          this.faces["D"].rotateCC();
          mutate([F[6], R[6], B[6], L[6]]);
          mutate([F[7], R[7], B[7], L[7]]);
          mutate([F[8], R[8], B[8], L[8]]);
          return;
        case "F":
          this.faces["F"].rotateC();
          mutate([L[8], D[2], R[0], U[6]]);
          mutate([L[5], D[1], R[3], U[7]]);
          mutate([L[2], D[0], R[6], U[8]]);
          return;
        case "Fi":
          this.faces["F"].rotateCC();
          mutate([U[6], R[0], D[2], L[8]]);
          mutate([U[7], R[3], D[1], L[5]]);
          mutate([U[8], R[6], D[0], L[2]]);
          return;
        case "U":
          this.faces["U"].rotateC();
          mutate([L[2], F[2], R[2], B[2]]);
          mutate([L[1], F[1], R[1], B[1]]);
          mutate([L[0], F[0], R[0], B[0]]);
          return;
        case "Ui":
          this.faces["U"].rotateCC();
          mutate([B[2], R[2], F[2], L[2]]);
          mutate([B[1], R[1], F[1], L[1]]);
          mutate([B[0], R[0], F[0], L[0]]);
          return;
        default:
          this.modcontext(argMove);
      }
    };

    objCube.prototype.modcontext = function(argMove) {};

    return objCube;

  })();

  foo = new objCube();

  foo.print();

  foo.importString('RRRRRRRRRLLLLLLLLLBBBBBBBBBDDDDDDDDDFFFFFFFFFUUUUUUUUU');

  foo.print();

  foo.importString('012345678012345678BBBBBBBBB012345678FFFFFFFFF012345678');

  foo.print();

  foo.importString('RRRRRRRRRLLLLLLLLL012345678DDDDDDDDD012345678UUUUUUUUU');

  foo.print();

}).call(this);
