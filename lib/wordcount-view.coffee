
module.exports =
class WordcountView
  CSS_SELECTED_CLASS: 'wordcount-select'

  constructor: ->
    @element = document.createElement 'div'
    @element.classList.add('word-count')
    @element.classList.add('inline-block')

    @divWords = document.createElement 'div'

    @element.appendChild(@divWords)


  update_count: (editor) ->
    text = @getCurrentText editor
    pageCount = @count text
    @divWords.innerHTML = "원고지 #{pageCount || 0} 장"
    # @divWords.innerHTML += (" | #{charCount || 0} C") unless atom.config.get('wordcount.hidechars')
    # priceResult = pageCount*atom.config.get('wordcount.wordprice')
    # @divWords.innerHTML += (" | #{priceResult.toFixed(2) || 0} ")+atom.config.get('wordcount.currencysymbol') if atom.config.get('wordcount.showprice')
    if goal = atom.config.get 'wordcount.goal'
      if not @divGoal
        @divGoal = document.createElement 'div'
        @divGoal.style.width = '100%'
        @element.appendChild @divGoal
      green = Math.round(pageCount / goal * 100)
      green = 100 if green > 100
      color = atom.config.get 'wordcount.goalColor'
      @divGoal.style.background = '-webkit-linear-gradient(left, ' + color + ' ' + green + '%, transparent 0%)'
      percent = parseFloat(atom.config.get 'wordcount.goalLineHeight') / 100
      height = @element.style.height * percent
      @divGoal.style.height = height + 'px'
      @divGoal.style.marginTop = -height + 'px'

  getCurrentText: (editor) =>
    selection = editor.getSelectedText()
    if selection
      @element.classList.add @CSS_SELECTED_CLASS
    else
      @element.classList.remove @CSS_SELECTED_CLASS
    text = editor.getText()
    selection || text

  count: (text) ->
    if atom.config.get('wordcount.ignorecode')
      codePatterns = [/`{3}(.|\s)*?(`{3}|$)/g, /[ ]{4}.*?$/gm]
      for pattern in codePatterns
        text = text?.replace pattern, ''
    pages = 0
    lines = text?.split "\n"
    for line in lines
      line = line?.replace /\r$/g, ''
      line = line?.replace /\.{3}/g, 'A'
      line = line?.replace /[\.,]+/g, ''
      # Half size characters: marked(*)
      #  002x  SP !  "  #* $* %* &* '  (  )  ** +* ,  -* .  /*
      #  003x  0* 1  2  3  4  5  6  7  8  9* :  ;  <  =* >  ?
      #  004x  @* A  B  C  D  E  F  G  H  I  J  K  L  M  N  O
      #  005x  P  Q  R  S  T  U  V  W  X  Y  Z  [  \* ]  ^* _
      #  006x  `* a* b  c  d  e  f  g  h  i  j  k  l  m  n  o
      #  007x  p  q  r  s  t  u  v  w  x  y  z* {  |* }  ~  DEL
      line = line?.replace /[#\$%&\*\+-\/0-9=@\\\^`a-z\|\u00A1-\u2FFF]{2}/g, 'A'
      len = line?.length
      len = 1 if len == 0
      # console.log line + " => " + len + "," + (Math.ceil(len / 20) * 0.1).toFixed(1)
      pages += Math.ceil(len / 20) * 0.1
    pages.toFixed(1)
