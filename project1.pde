//Random Color
var getRandomColor = function () {
  return '#' +
    (function (color) {
      return (color += '0123456789abcdef'[Math.floor(Math.random() * 16)])
        && (color.length == 6) ? color : arguments.callee(color);
    })('');
}
function Game() {
  this.speed = 600;this.remove = false;this.gameover = false;this.pause = false;;this.timer = null;this.score = 0;this.blockArea = []
  this.x = 150;this.y = 0;this.r2 = null;this.r1 = null;this.r3 = null;this.r4 = null;
  this.map = [
    // T 0 ----ok
    [
      [[this.x, this.y - 30],[this.x - 30, this.y],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x - 30, this.y - 30],[this.x, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x + 30, this.y - 30],[this.x, this.y]], //ok
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x + 30, this.y - 30],[this.x, this.y]] //ok
    ],
    // L 1 ----ok
    [
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x + 30, this.y - 30],[this.x - 30, this.y],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x - 30, this.y - 60],[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x + 30, this.y - 30],[this.x - 30, this.y]] //ok
    ],
    // J 2 ----ok
    [
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y],[this.x - 30, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x - 30, this.y],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x + 30, this.y - 60],[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x + 30, this.y - 30],[this.x + 30, this.y]] //ok
    ],
    // O 3 ----ok
    [
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x - 30, this.y],[this.x, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x - 30, this.y],[this.x, this.y]], //ok
      
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x - 30, this.y],[this.x, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x - 30, this.y],[this.x, this.y]] //ok
    ],
    // | 4 ----
    [
      [[this.x, this.y - 90],[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y]], //ok
      [[this.x - 60, this.y],[this.x - 30, this.y],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x, this.y - 90],[this.x, this.y - 60],[this.x, this.y - 30],[this.x, this.y]], //ok
      [[this.x - 60, this.y],[this.x - 30, this.y],[this.x, this.y],[this.x + 30, this.y]] //ok
    ],
    // Z 5 ----
    [
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x - 30, this.y - 30],[this.x - 30, this.y]], //ok
      [[this.x - 30, this.y - 30],[this.x, this.y - 30],[this.x, this.y],[this.x + 30, this.y]], //ok
      [[this.x, this.y - 60],[this.x, this.y - 30],[this.x - 30, this.y - 30],[this.x - 30, this.y]] //ok
    ]
  ]
  this.startGame()
}
Game.prototype.wangge = function () {
  for (var i = 0; i < 15; i++) {
    for (var k = 0; k < 11; k++) {
      $('<div class="wangge"></div>').css({'top': i * 30 + 'px','left': k * 30 + 'px'}).appendTo('#gameBox')
    }
  }
}
Game.prototype.getRandom = function () {
  this.r3 = Math.floor(Math.random() * 6)
  this.r4 = Math.floor(Math.random() * 4)
}
Game.prototype.yulan = function () {
  var bgcolor = getRandomColor();
  for (var i = 0; i < 4; i++) {
    $('<span class="block"></span>').css({'top': this.map[this.r3][this.r4][i][1] + 90 + 'px','left': this.map[this.r3][this.r4][i][0] - 90 + 'px','background': bgcolor}).attr('next', true).appendTo('.next')
  }
}
Game.prototype.createBlock = function () {
  var bgcolor = getRandomColor();
  this.r1 = this.r3
  this.r2 = this.r4
  for (var i = 0; i < 4; i++) {
    $('<span class="block" ></span>').css({'top': this.map[this.r1][this.r2][i][1] + 'px','left': this.map[this.r1][this.r2][i][0] + 'px','background': bgcolor}).attr('move', true).appendTo('#gameBox')
  }
}

Game.prototype.autoMove = function () {
  var that = this;
  return $.Deferred(function (stop) {

    function move() {
      that.timer = setTimeout(function () {
        var dD0 = that.shifouMoveDown(0, 30)
        var dD1 = that.shifouMoveDown(1, 30)
        var dD2 = that.shifouMoveDown(2, 30)
        var dD3 = that.shifouMoveDown(3, 30)
        if (that.gameover == true) {
          alert('Game Over!')
          $('.mask').css({'display': 'flex'}).find('button').text('Play again')
          $('#gameBox').find('span').remove();$('.next').find('span').remove();$('.score').text('0')
        } else {
          $.when(dD0, dD1, dD2, dD3).then(function () {
            that.y += 30
            that.updateMap()
            $('.block[move=true]').each(function (i) {
              $(this).css({'top': that.map[that.r1][that.r2][i][1] + 'px'})
            })
            move()
          }).catch(function () {
            that.y = 0;that.x = 150;
            that.updateMap();
            that.shifouxiaochu()
            setTimeout(function () {
              if (that.remove == true) {
                that.remove = false
                setTimeout(function () {
                  $('.score').animate({'font-size': '26px'}, 100).animate({'font-size': '26px'}, 500).animate({'font-size': '16px'}, 100)
                  stop.resolve()
                }, 1000)
              } else {
                setTimeout(function () {stop.resolve()}, 100)
              }
            }, 10)
          })
        }
      }, that.speed)
    }
    move()
    $('#pause').click(function () {
      if (that.gameover == false) {
        if (that.pause == false) {
          clearTimeout(that.timer)
          that.pause = true
          $(this).text('Start')
        } else {
          that.pause = false
          move()
          $(this).text('Suspend')
        }
      }
    })
  })
}
