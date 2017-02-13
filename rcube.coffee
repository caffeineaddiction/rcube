
mutate = (aBlocks) ->
  tBlock = aBlocks[0]()
  for i in [1...aBlocks.length]
    aBlocks[i-1](aBlocks[i]())
  aBlocks[aBlocks.length - 1](tBlock)
  return 

class objBlock
  constructor: (@Value) ->
    return (aValue) =>
      if aValue?
        @Value = aValue
      return @Value

class objFace
  constructor: (@ID, aArray) ->
    @blocks = {}
    for i in [0..8] # 0 .. aArray.length
      @blocks[i] = new objBlock(aArray[i])

    @sides = 
      0: [ @blocks[0], @blocks[1], @blocks[2] ] # 0 1 2
      1: [ @blocks[2], @blocks[3], @blocks[8] ] # 3 4 5
      2: [ @blocks[8], @blocks[7], @blocks[6] ] # 6 7 8
      3: [ @blocks[6], @blocks[3], @blocks[0] ]
    return @

  rotateC: () ->
    b = @blocks
    mutate([ b[6],b[8],b[2],b[0] ])
    mutate([ b[3],b[7],b[5],b[1] ])
    return

  rotateCC: () ->
    b = @blocks
    mutate([ b[0],b[2],b[8],b[6] ])
    mutate([ b[1],b[5],b[7],b[3] ])
    return

class objCube
  constructor: (argCube) ->
    switch toString.call(argCube)
      when '[object String]'
        pass
      when '[object Array]'
        pass
      when '[object Object]'
        pass
      else
        @initCube()

    return @

  initCube: (aR, aL, aB, aD, aF, aU) ->
    @faces =  
      "R": new objFace("R", aR ? Array(10).join("R"))
      "L": new objFace("L", aL ? Array(10).join("L"))
      "B": new objFace("B", aB ? Array(10).join("B"))
      "D": new objFace("D", aD ? Array(10).join("D"))
      "F": new objFace("F", aF ? Array(10).join("F"))
      "U": new objFace("U", aU ? Array(10).join("U"))
    return

  importString: (argString) ->
    tArray = argString.split('')
    tOut = []
    for tSide in [0..5]
      tOut.push([])
      for tCube in [0..8]
        tOut[tSide].push(tArray.pop())
      tOut[tSide].reverse()
    return @importArray(tOut.reverse())

  exportString: () ->
    tArray = @exportArray()
    tOut = []
    for i in tArray
      for j in i
        tOut.push(j)
    return tOut.join("")

  importArray: (arg) ->
    @initCube(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5])

  exportArray: () ->
    tOut = []
    tOut.push( block() for k,block of @faces["R"].blocks )
    tOut.push( block() for k,block of @faces["L"].blocks )
    tOut.push( block() for k,block of @faces["B"].blocks )
    tOut.push( block() for k,block of @faces["D"].blocks )
    tOut.push( block() for k,block of @faces["F"].blocks )
    tOut.push( block() for k,block of @faces["U"].blocks )
    return tOut

  print: () ->
    R = @faces["R"].blocks
    L = @faces["L"].blocks
    B = @faces["B"].blocks
    D = @faces["D"].blocks
    F = @faces["F"].blocks
    U = @faces["U"].blocks
    console.log("~ ~ ~ #{U[0]()} #{U[1]()} #{U[2]()} ~ ~ ~ ~ ~ ~ ")
    console.log("~ ~ ~ #{U[3]()} #{U[4]()} #{U[5]()} ~ ~ ~ ~ ~ ~ ")
    console.log("~ ~ ~ #{U[6]()} #{U[7]()} #{U[8]()} ~ ~ ~ ~ ~ ~ ")
    console.log("#{L[0]()} #{L[1]()} #{L[2]()} #{F[0]()} #{F[1]()} #{F[2]()} #{R[0]()} #{R[1]()} #{R[2]()} #{B[0]()} #{B[1]()} #{B[2]()} ")
    console.log("#{L[3]()} #{L[4]()} #{L[5]()} #{F[3]()} #{F[4]()} #{F[5]()} #{R[3]()} #{R[4]()} #{R[5]()} #{B[3]()} #{B[4]()} #{B[5]()} ")
    console.log("#{L[6]()} #{L[7]()} #{L[8]()} #{F[6]()} #{F[7]()} #{F[8]()} #{R[6]()} #{R[7]()} #{R[8]()} #{B[6]()} #{B[7]()} #{B[8]()} ")
    console.log("~ ~ ~ #{D[0]()} #{D[1]()} #{D[2]()} ~ ~ ~ ~ ~ ~ ")
    console.log("~ ~ ~ #{D[3]()} #{D[4]()} #{D[5]()} ~ ~ ~ ~ ~ ~ ")
    console.log("~ ~ ~ #{D[6]()} #{D[7]()} #{D[8]()} ~ ~ ~ ~ ~ ~ ")
    console.log("")
    return

  shift: (argMove) ->
    R = @faces["R"].blocks
    L = @faces["L"].blocks
    B = @faces["B"].blocks
    D = @faces["D"].blocks
    F = @faces["F"].blocks
    U = @faces["U"].blocks
    switch argMove
      when "R"  # Right C
        @faces["R"].rotateC()
        mutate([ F[8],D[8],B[0],U[8] ])
        mutate([ F[5],D[5],B[3],U[5] ])
        mutate([ F[2],D[2],B[6],U[2] ])
        return
      when "Ri" # Right CC
        @faces["R"].rotateCC()
        mutate([ U[8],B[0],D[8],F[8] ])
        mutate([ U[5],B[3],D[5],F[5] ])
        mutate([ U[2],B[6],D[2],F[2] ])
        return
      when "L"  # Left C
        @faces["L"].rotateC()
        mutate([ B[8],D[0],F[0],U[0] ])
        mutate([ B[5],D[3],F[3],U[3] ])
        mutate([ B[2],D[6],F[6],U[6] ])
        return
      when "Li" # Left CC
        @faces["L"].rotateCC()
        mutate([ U[0],F[0],D[0],B[8] ])
        mutate([ U[3],F[3],D[3],B[5] ])
        mutate([ U[6],F[6],D[6],B[2] ])
        return
      when "B"  # Back C
        @faces["B"].rotateC()
        mutate([ R[8],D[6],L[0],U[2] ])
        mutate([ R[5],D[7],L[3],U[1] ])
        mutate([ R[2],D[8],L[6],U[0] ])
        return
      when "Bi" # Back CC
        @faces["B"].rotateCC()
        mutate([ U[2],L[0],D[6],R[8] ])
        mutate([ U[1],L[3],D[7],R[5] ])
        mutate([ U[0],L[6],D[8],R[2] ])
        return
      when "D"  # Bottom C
        @faces["D"].rotateC()
        mutate([ L[6],B[6],R[6],F[6] ])
        mutate([ L[7],B[7],R[7],F[7] ])
        mutate([ L[8],B[8],R[8],F[8] ])
        return
      when "Di" # Bottom CC
        @faces["D"].rotateCC()
        mutate([ F[6],R[6],B[6],L[6] ])
        mutate([ F[7],R[7],B[7],L[7] ])
        mutate([ F[8],R[8],B[8],L[8] ])
        return
      when "F"  # Face C
        @faces["F"].rotateC()
        mutate([ L[8],D[2],R[0],U[6] ])
        mutate([ L[5],D[1],R[3],U[7] ])
        mutate([ L[2],D[0],R[6],U[8] ])
        return
      when "Fi" # Face CC
        @faces["F"].rotateCC()
        mutate([ U[6],R[0],D[2],L[8] ])
        mutate([ U[7],R[3],D[1],L[5] ])
        mutate([ U[8],R[6],D[0],L[2] ])
        return
      when "U"  # Top C
        @faces["U"].rotateC()
        mutate([ L[2],F[2],R[2],B[2] ])
        mutate([ L[1],F[1],R[1],B[1] ])
        mutate([ L[0],F[0],R[0],B[0] ])
        return
      when "Ui" # Top CC
        @faces["U"].rotateCC()
        mutate([ B[2],R[2],F[2],L[2] ])
        mutate([ B[1],R[1],F[1],L[1] ])
        mutate([ B[0],R[0],F[0],L[0] ])
        return
      else
        @modcontext(argMove)
    return

  modcontext: (argMove) ->
    return

foo = new objCube()
foo.print()
foo.importString('RRRRRRRRRLLLLLLLLLBBBBBBBBBDDDDDDDDDFFFFFFFFFUUUUUUUUU')
foo.print()
foo.importString('012345678012345678BBBBBBBBB012345678FFFFFFFFF012345678')
foo.print()
foo.importString('RRRRRRRRRLLLLLLLLL012345678DDDDDDDDD012345678UUUUUUUUU')
foo.print()