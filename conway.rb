require 'fox16'
include Fox

class GameButton < FXButton
  attr_accessor :nextColor
end

class HelloWorldWindow < FXMainWindow
  def initialize(app)
    super(app, 'Hello World Program')

    hframe = FXHorizontalFrame.new(self)
    @mtx = FXMatrix.new(hframe, 20)

    400.times do
      btn = GameButton.new(@mtx, '', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 25, :height => 25)
      btn.backColor = "white"
      btn.connect(SEL_COMMAND) do
        if btn.backColor == 4294967295 #white
          btn.backColor = "red"
        elsif btn.backColor != 4294967295
          btn.backColor = "white"
        end
      end
    end

    step_btn = FXButton.new(hframe, '', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 40, :height => 40)
    step_btn.text = "Step"
    step_btn.backColor = "Yellow"
    step_btn.connect(SEL_COMMAND) do
      step
    end

    start_btn = FXButton.new(hframe, '', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 40, :height => 40)
    start_btn.text = "Start"
    start_btn.backColor = "Green"
    start_btn.connect(SEL_COMMAND) do
      if start_btn.text == "Start"
        start_btn.text = "Stop"
        start_btn.backColor = "Red"
      elsif start_btn.text == "Stop"
        start_btn.text = "Start"
        start_btn.backColor = "Green"
      end
    end

      app.addTimeout(500, :repeat => true) do
        if start_btn.text == "Stop"
        step
        end
        end

  end

  def step
    20.times do |currentrow|
      20.times do |currentcolumn|
        neighborcount = 0
        currentsquare = @mtx.childAtRowCol(currentrow, currentcolumn)
        topsquare = @mtx.childAtRowCol(currentrow - 1, currentcolumn)
        bottomsquare = @mtx.childAtRowCol(currentrow + 1, currentcolumn)
        leftsquare = @mtx.childAtRowCol(currentrow, currentcolumn - 1)
        rightsquare = @mtx.childAtRowCol(currentrow, currentcolumn + 1)
        topleftsquare = @mtx.childAtRowCol(currentrow - 1, currentcolumn - 1)
        toprightsquare = @mtx.childAtRowCol(currentrow - 1, currentcolumn + 1)
        bottomrightsquare = @mtx.childAtRowCol(currentrow + 1, currentcolumn + 1)
        bottomleftsquare = @mtx.childAtRowCol(currentrow + 1, currentcolumn - 1)

        if topsquare && topsquare.backColor != 4294967295 #all of them are white
          neighborcount = neighborcount + 1
        end
        if bottomsquare && bottomsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if leftsquare && leftsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if rightsquare && rightsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if topleftsquare && topleftsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if toprightsquare && toprightsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if bottomrightsquare && bottomrightsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end
        if bottomleftsquare && bottomleftsquare.backColor != 4294967295
          neighborcount = neighborcount + 1
        end

        if currentsquare.backColor != 4294967295 && neighborcount < 2
          currentsquare.nextColor = 4294967295 #white
        end

        if currentsquare.backColor == 4294967295 && neighborcount == 3
          currentsquare.nextColor = 4278190335 #red
        end

        if currentsquare.backColor != 4294967295 && neighborcount > 3
          currentsquare.nextColor = 4294967295
        end

        if currentsquare.backColor == 4278190335 && neighborcount == 3
          currentsquare.nextColor = 4278232575 #orange
        end

        if currentsquare.backColor == 4278190335 && neighborcount == 2
          currentsquare.nextColor = 4278232575 #orange
        end

        if currentsquare.backColor == 4278232575 && neighborcount == 3
          currentsquare.nextColor = 4278255615 #yellow
        end

        if currentsquare.backColor == 4278232575 && neighborcount == 2
          currentsquare.nextColor = 4278255615 #yellow
        end

        if currentsquare.backColor == 4278255615 && neighborcount == 3
          currentsquare.nextColor = 4278255360 #green
        end

        if currentsquare.backColor == 4278255615 && neighborcount == 2
          currentsquare.nextColor = 4278255360 #green
        end

        if currentsquare.backColor == 4278255360 && neighborcount == 3
          currentsquare.nextColor = 4294901760 #blue
        end

        if currentsquare.backColor == 4278255360 && neighborcount == 2
          currentsquare.nextColor = 4294901760 #blue
        end

        if currentsquare.backColor == 4294901760 && neighborcount == 3
          currentsquare.nextColor = 4293927072 #violet
        end

        if currentsquare.backColor == 4294901760 && neighborcount == 2
          currentsquare.nextColor = 4293927072 #violet
        end

        if currentsquare.backColor == 4293927072 && neighborcount == 3
          currentsquare.nextColor = 4278190080 #black
        end

        if currentsquare.backColor == 4293927072 && neighborcount == 2
          currentsquare.nextColor = 4278190080 #black
        end
      end
    end

    20.times do |currentrow|
      20.times do |currentcolumn|
        currentsquare = @mtx.childAtRowCol(currentrow, currentcolumn)
        if currentsquare.nextColor
          currentsquare.backColor = currentsquare.nextColor
          currentsquare.nextColor = nil
        end
      end
    end
  end

  # don't touch this
  def create
    super
    self.show(PLACEMENT_SCREEN)
  end
end

# never touch these
app = FXApp.new
HelloWorldWindow.new(app)
app.create
app.run
