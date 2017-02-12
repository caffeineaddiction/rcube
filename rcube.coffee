
class objFace
  constructor: (@Cube, argBlocks) ->
    @links = {}
    #tArray = Array(9).join(@Cube.sides.length).split("")
    if toString.call(argBlocks) is '[object Array]'
      @blocks = tArray  
    else
      @blocks = []
      for n in [0..8]
        @blocks.push(n)
    return @
    
class objCube
  constructor: (argCube) ->
    switch toString.call(argCube)
      when '[object String]'
        @importString(argCube)
      when '[object Array]'
        @importArray(argCube)
      when '[object Object]'
        return argCube
      else
        @initCube()
    return @

  initCube: () ->
    @sides =  
      "R": new objFace(@)
      "L": new objFace(@)
      "B": new objFace(@)
      "D": new objFace(@)
      "F": new objFace(@)
      "U": new objFace(@)
    @bindFaces()
    return

  bindFaces: () ->
    @sides["R"] = 
      "12": @sides["U"]["03"]
      "09": @sides["F"]["03"]
      "06": @sides["D"]["03"]
      "03": @sides["B"]["03"]
    
    @sides["L"] = 
      "12": @sides["U"]["09"]
      "09": @sides["B"]["09"]
      "06": @sides["D"]["09"]
      "03": @sides["F"]["09"]
    
    @sides["B"] = 
      "12": @sides["D"]["06"]
      "09": @sides["L"]["09"]
      "06": @sides["U"]["12"]
      "03": @sides["R"]["03"]
    
    @sides["D"] = 
      "12": @sides["F"]["06"]
      "09": @sides["L"]["06"]
      "06": @sides["B"]["12"]
      "03": @sides["R"]["06"]
    
    @sides["F"] = 
      "12": @sides["U"]["06"]
      "09": @sides["L"]["03"]
      "06": @sides["D"]["12"]
      "03": @sides["R"]["09"]

    @sides["U"] = 
      "12": @sides["B"]["06"]
      "09": @sides["L"]["12"]
      "06": @sides["F"]["12"]
      "03": @sides["R"]["12"]

    return

  # tArray = []
  # for char in argString.split('')
  #   if char is 'i'
  #     tArray.push(tArray.pop() + char)
  #   else
  #     tArray.push(char)

  mutate: (argMove) ->
    switch argMove
      when "R"  # Right C
        pass
      when "Ri" # Right CC
        pass
      when "L"  # Left C
        pass
      when "Li" # Left CC
        pass
      when "B"  # Back C
        pass
      when "Bi" # Back CC
        pass
      when "D"  # Bottom C
        pass
      when "Di" # Bottom CC
        pass
      when "F"  # Face C
        pass
      when "Fi" # Face CC
        pass
      when "U"  # Top C
        pass
      when "Ui" # Top CC
        pass
      else
        modcontext(argMove)
    return

  modcontext: (argMove) ->

  importString: (argString) ->
    tArray = argString.split('')
    tOut = []
    for tSide in [0..5]
      tOut.push([])
      for tCube in [0..8]
        tOut[tSide].push(tArray.pop())
    return @importArray(tOut)

  exportString: () ->
    return

  importArray: (argArray) ->
    for n in argArray
      @sides.push( new objFace(@, n))
    return

  exportArray: () ->
    return