//====================================================
//          ***** Chinese Dark Chess *****
//====================================================
//
//        帥 將    King(generals)
//
//        仕 士    Advisors(Mandarins,assistants,guards)
//
//        相 象    Elephants(bishops,ministers)
//
//        俥 車    Rooks(chariots)
//
//        傌 馬    Knights(horses)
//
//        炮 包    Cannons
//
//        兵 卒    Pawns(soldiers)
//
//====================================================
import UIKit


    //initial original = 0
//    var arr = [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]
    //initial original = 2
//    var arr = [[2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2]]
var arr = [[1, 0, 0, 1, 0, 1, 2, 2], [0, 0, 1, 0, 1, 2, 0, 2], [1, 2, 0, 1, 2, 0, 2, 0], [1, 1, 0, 1, 0, 0, 0, 1]]

enum Axis
{
    case axis_X
    case axis_Y
}

class Chess{
    //var postion = [[Int]]()
    var X: Int
    var Y: Int
    var status: Int
    
    init(){
        self.X = 0
        self.Y = 0
        //arr[self.X][self.Y] = 0
        self.status = 0
    }
    
    init(status: Int, X: Int, Y: Int)
    {
        self.X = X
        self.Y = Y
        arr[self.X][self.Y] = status
        self.status = status
    }
    
    func setPos(X: Int, Y: Int){
        self.X = X
        self.Y = Y
    }

    func setSts(status: Int){
        arr[self.X][self.Y] = status
        self.status = status
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var showChessState: UITextView!
    @IBOutlet weak var cannonsPos: UITextField!
    @IBOutlet weak var eatenPos: UITextField!
    @IBOutlet weak var showCheckResult: UITextView!
    
    var Chess_A = Chess()
    var Chess_B = Chess()
    var checkResultStr : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showCheckResult.text = ""
        
        #if true
        let numbers = 0...31
        let shuffledNumbers = numbers.shuffled()
        print("array001 = \(shuffledNumbers)")
        #endif
        
        showNewChessDistributed()

        #if false

//        Chess_A.setSts(status: 1)
        print("tip_005:\(arr)")
//var arr = [[1, 0, 0, 1, 0, 1, 2, 2], [1, 0, 0, 1, 1, 2, 2, 2], [1, 2, 0, 1, 2, 1, 2, 2], [1, 1, 0, 1, 0, 0, 0, 1]]
//        Chess_A.setPos(X: 2, Y: 5)
//        Chess_B.setPos(X: 0, Y: 5)
//        Chess_B.setPos(X: 1, Y: 5)
        Chess_A.setPos(X: 0, Y: 0)
        Chess_B.setPos(X: 0, Y: 6)
        
        print("A:(\(Chess_A.X),\(Chess_A.Y)), B:(\(Chess_B.X),\(Chess_B.Y))")

        checkCannons(objA: Chess_A, objB: Chess_B)
        #endif


    }
    
    @IBAction func checkRule(_ sender: UIButton) {
        print("tip_103, push button!")
        self.showCheckResult.text = ""
        checkResultStr = ""
        var cannonsPosStr : String = cannonsPos.text!
        var cannonsPosStrArr = cannonsPosStr.components(separatedBy: ",")
        
        var eatenPosStr : String = eatenPos.text!
        var eatenPosStrArr = eatenPosStr.components(separatedBy: ",")
        let cannosPosX = Int(cannonsPosStrArr[0])!
        let cannosPosY = Int(cannonsPosStrArr[1])!
        let eatenPosX = Int(eatenPosStrArr[0])!
        let eatenPosY = Int(eatenPosStrArr[1])!
        print("tip_105: \(cannosPosX),\(cannosPosY),\(eatenPosX),\(eatenPosY)")
        
        Chess_A.setPos(X: cannosPosX, Y: cannosPosY)
        Chess_B.setPos(X: eatenPosX, Y: eatenPosY)
        print("A:(\(Chess_A.X),\(Chess_A.Y)), B:(\(Chess_B.X),\(Chess_B.Y))")
        checkCannons(objA: Chess_A, objB: Chess_B)
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    
    func showNewChessDistributed()
    {
        var arrString : String = ""
        for n in 0...3
        {
            arrString = arrString + "\(arr[n])" + "\n"
        }
        arrString = arrString + "0:空格,1:亮棋,2:蓋棋" + "\n"
        self.showChessState.text = arrString
    }
    
    func checkCannons(objA:Chess, objB:Chess) -> Bool
    {
        print("checkCannons: A:(\(objA.X),\(objA.Y)), B:(\(objB.X),\(objB.Y))")
        
        //check是否在同一個行或列上面
        if(objA.X != objB.X) && (objA.Y != objB.Y)
        {
            print("你的棋子不可以這麼走!不同行列!")
            self.showCheckResult.text = "你的棋子不可以這麼走!不同行列!"
            return false
        }else{
            //print("目前是正確的 ,同行或同列")
            //checkResultStr = "目前是正確的 ,同行或同列" + "\n"
        }
        switch (objA.X == objB.X, objA.Y == objB.Y) {
        case (true, false): //objA.X == objB.X
            //print("同列")
            //axis_rc : 在同一行或同一列的哪一行或哪一列,來做檢查
            //axis_xy : 表示是要檢查X軸或是Y軸上,此軸上(同軸)的棋子
            //比如: [0,0]吃[0,5],則axis_rc = 0, axis_xy = Axis.axis_X
            if(objB.Y > objA.Y)
            {
                let from_pos = objA.Y+1
                let to_pos = objB.Y
                let axis_rc = objA.X
                let axis_xy = Axis.axis_X
                print("=== tip_021:\(from_pos),\(to_pos),\(axis_rc),\(axis_xy) ===")
                let result = checkSubCannons(from_Pos:from_pos, to_Pos:to_pos, axis_XY:axis_xy, axis_RC:axis_rc)
                return result
            }else{
                let from_pos = objB.Y+1
                let to_pos = objA.Y
                let axis_rc = objA.X
                let axis_xy = Axis.axis_X
                print("=== tip_022:\(from_pos),\(to_pos),\(axis_rc),\(axis_xy) ===")
                let result = checkSubCannons(from_Pos:from_pos, to_Pos:to_pos, axis_XY:axis_xy, axis_RC:axis_rc)
                return result
            }
        case (false, true): //objA.Y == objB.Y
//            print("同行")
            if(objB.X > objA.X)
            {
                let from_pos = objA.X+1
                let to_pos = objB.X
                let axis_rc = objA.Y
                let axis_xy = Axis.axis_Y
                print("=== tip_023:\(from_pos),\(to_pos),\(axis_rc),\(axis_xy) ===")
                let result = checkSubCannons(from_Pos:from_pos, to_Pos:to_pos, axis_XY:axis_xy, axis_RC:axis_rc)
                return result
            }else{
                let from_pos = objB.X+1
                let to_pos = objA.X
                let axis_rc = objA.Y
                let axis_xy = Axis.axis_Y
                //print("=== tip_024:\(axis_rc),\(axis_xy) ===")
                print("=== tip_024:\(from_pos),\(to_pos),\(axis_rc),\(axis_xy) ===")
                let result = checkSubCannons(from_Pos:from_pos, to_Pos:to_pos, axis_XY:axis_xy, axis_RC:axis_rc)
                return result
            }
        case (true, true): //objA.X,Y == objB.X,Y
            print("錯誤, 同一位置!")
            self.showCheckResult.text = "錯誤, 同一位置!"
        default:
            print("錯誤, 不明!")
            self.showCheckResult.text = "錯誤, 不明!"
        }
        return false
    }
    
    //axis_RC : working Row or Column
    //axis_XY : arr using [axis_RC][] or [][axis_RC]
    func checkSubCannons(from_Pos:Int , to_Pos:Int, axis_XY:Axis, axis_RC:Int) -> Bool
    {
        var count:Int = 0
        if(axis_XY == Axis.axis_X)
        {
            print("using axis: \(Axis.axis_X)")
            for n in from_Pos..<to_Pos
            {
                //print(n)
                if(arr[axis_RC][n] != 0)
                {
                    count += 1
                }
            }
        }else{
            print("using axis: \(Axis.axis_Y)")
            
            for n in from_Pos..<to_Pos
            {
                //print(n)
                if(arr[n][axis_RC] != 0)
                {
                    count += 1
                }
            }
        }
        if count != 1{
            print("\(count),你不可以這樣下, 中間只能有一格棋子!")
            self.showCheckResult.text = "你不可以這樣下, 中間只能有一格棋子!"
            return false
        }else{  //count == 1
            print("\(count),目前是正確的 003...")
            self.showCheckResult.text = "砲這樣吃法是正確的!"
            return true
        }
    }
    

}

