import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines=new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private MSButton newMine;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    textSize(20);
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0; r<NUM_ROWS;r++){
      for(int c=0; c<NUM_COLS;c++)
      buttons[r][c] = new MSButton (r,c);}
    
    
    setMines();
}
public void setMines()
{
    
    for (int i=0; i<NUM_ROWS; i++)
       for (int j=0; j<NUM_COLS; j++)
          if (Math.random()<0.2)
           {
             newMine = new MSButton(i,j);
             if (mines.contains(newMine)==false)
              {
                 mines.add(newMine);
                 buttons[i][j].isMine = true;
              }
           }
                 
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r<NUM_ROWS; r++)
      for(int c = 0; c<NUM_COLS; c++)
      if (buttons[r][c].clicked == false && mines.contains(this)== false)
       return false;
    
   return true;
}
public void displayLosingMessage()
{
   for(int r = 0; r<NUM_ROWS; r++)
      for(int c = 0; c<NUM_COLS; c++)
      {
        textSize(8);
        buttons[r][c].setLabel("Lost");
      
      }

  
  
  
  
}
public void displayWinningMessage()
{
 
  for(int r = 0; r<NUM_ROWS; r++)
      for(int c = 0; c<NUM_COLS; c++)
      {
        textSize(8);
        buttons[r][c].setLabel("WIN");
       
      }
    
}
public boolean isValid(int r, int c)
{
    if ((r<NUM_ROWS && r>=0) && (c<NUM_COLS && c>=0))
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    
    
    for(int x = row-1; x < row+2; x++)
      for(int y = col-1; y < col+2; y++)
      {
        if(isValid(x,y)==true && buttons[x][y].isMine == true )
        numMines++;
      }
    
    
    return numMines;
}
   

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged, isMine;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        isMine = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT)
          flagged = !flagged;
        else if(mines.contains(this))
          displayLosingMessage();
        else if(countMines(myRow, myCol) >0)
          {
          textSize(10);
          setLabel(countMines(myRow, myCol));
          }
        else 
          mousePressed();   
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
