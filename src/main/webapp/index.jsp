<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>assignment4</title>
    <style type="text/css">
        /*.circle {
            width: 1000px;
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        */

        .anim {
            position: absolute;
            left: 0px;
            width: 150px;
            height: 150px;
            background: blue;
            font-size: larger;
            color: white;
            border-radius: 10px;
            padding: 1em;
        }

        #canvas1 {}
    </style>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" ;; integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>

<body>
<div class="container">
    <div class="row">

        <div class="col-md-1">
            <button type="button" id ="runLeft"class="btn btn-success" style="margin-top: 30px; ">RunLeft</button>
            <button type="button" id ="runRight"class="btn btn-success" style="margin-top: 30px; ">RunRight</button>
            <button type="button" id ="runBoth"class="btn btn-success" style="margin-top: 30px;  ">RunBothSide</button>
            <%--<button type="button" id ="run"class="btn btn-success" style="margin-top: 30px; ">Run</button>--%>
            <button type="button" id="stop" class="btn btn-warning" style="margin-top: 30px;">Stop</button>
        </div>

        <div class="col-md-10" style="margin-top: 20px">

            <canvas id="canvas1" width="1600" height="800"></canvas>
            <img src="images/train.jpg" id="train" hidden="hidden" />
            <img src="images/trainL.png" id="trainL" hidden="hidden" />
            <img src="images/trainR.png" id="trainR" hidden="hidden" />
        </div>

    </div>
</div>
<script type="text/javascript">
    var n = 100;
    var elem = document.getElementById("anim");

    // requestAnimationFrame的兼容性写法
    window.requestAnimFrame = (function() {
        return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.oRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            function( /* function FrameRequestCallback */ callback, /* DOMElement Element */ element) {
                window.setTimeout(callback, 1000 / 60);
            };
    })();

    window.cancelAnimationFrame = (function() {
        return window.cancelAnimationFrame ||
            window.webkitCancelAnimationFrame ||
            window.mozCancelAnimationFrame ||
            window.oCancelAnimationFrame ||
            function(timer) {
                window.clearTimeout(timer);
            };
    })();

    var canvas1 = document.getElementById("canvas1");
    var ctx = canvas1.getContext("2d");


    var stopMark=0;
    var stopMarkL=0;
    var stopMarkR=0;
    var lPos = 0;
     var rPos =1200;
     var rate=0;
     var gateMark=0;
     var gatePosition=0;
    var roadStatus=0;
    var stopL=0;
    var stopR=0;

    DrawSline(ctx);
    DrawDline(ctx);
    DrawShape(ctx);
    DrawLight();
    DrawGreen();
    //ctx.stroke();

    function drawL() {

        drawTrain(ctx,0);
        stopMark=requestAnimFrame(drawL);
       // console.log(stopMark);
        if((lPos%1200)==(150-110))
        {
            console.log(roadStatus);
            if(roadStatus==1)
            {
                stopL=1;
                if( stopMark) {
                    window.cancelAnimationFrame(stopMark);
                    stopMark = null;
                }

            }

            else {
                roadStatus=1;

            }

        }

        if((lPos%1200)==(300-110))
        {

                drawGateClose();
                DrawLight();
                DrawYellow();

        }
        if((lPos%1200)==(450-110))
        {

            DrawLight();
            DrawRed();

        }

        if((lPos%1200)==750)
        {
            drawGateOpen();
            DrawLight();
            DrawYellow();
        }

        if((lPos%1200)==900)
        {
            DrawLight();
            DrawGreen();
        }
        if((lPos%1200)==(1050))
        {
            roadStatus=0;
            if(stopR=1)
            {
                stopR=0;
                roadStatus=1;//再一次执行的位置是在停止时的下一个点
                drawR();

            }
        }


    }
    function drawR() {
        drawTrain(ctx,1);
        stopMark=requestAnimFrame(drawR);
        if((rPos%1200)==(1050-30))
        {
            if(roadStatus==1)
            {
                if( stopMark) {
                    window.cancelAnimationFrame(stopMark);
                    stopMark = null;
                }
                stopR=1;
            }
            else {
                roadStatus=1;
            }

        }
        if((rPos%1200)==(150-30))
        {
            roadStatus=0;
            if(stopL=1)
            {
                stopL=0;
                roadStatus=1;
                drawL();

            }


        }

        if((rPos%1200)==(900-30))
        {
            drawGateClose();
            DrawLight();
            DrawYellow();
        }
        if((rPos%1200)==(750-30))
        {

            DrawLight();
            DrawRed();
        }

        if((rPos%1200)==(450-140))
        {
            drawGateOpen();
            DrawLight();
            DrawYellow();
        }

        if((rPos%1200)==(300-140))
        {
            DrawLight();
            DrawGreen();
        }
    }

    function drawGateOpen() {
        ctx.clearRect(510, 255, 180, 10);
        ctx.clearRect(510, 335, 180, 10);
        // gatePosition--;
        gatePosition=gatePosition-2;
        ctx.fillStyle = "blue";
        ctx.fillRect(510, 255, gatePosition, 10);
        ctx.fillRect(510, 335, gatePosition, 10);
        //console.log(gatePosition==180);
        gateMark=requestAnimFrame(drawGateOpen);
        if(gatePosition<=10)
        {
            if(gateMark) {
                window.cancelAnimationFrame(gateMark);
                gateMark = null;
            }
        }

    }

    function drawGateClose() {
//        ctx.clearRect(510, 255, 180, 10);
//        ctx.clearRect(510, 335, 180, 10);
        gatePosition=2+gatePosition;
        ctx.fillStyle = "blue";
        ctx.fillRect(510, 255, gatePosition, 10);
        ctx.fillRect(510, 335, gatePosition, 10);
         //console.log(gatePosition==180);
        gateMark=requestAnimFrame(drawGateClose);
        if(gatePosition>=180)
        {
            if(gateMark) {
                window.cancelAnimationFrame(gateMark);
                gateMark = null;
            }
        }

    }

    function DrawGreen() {
        ctx.fillStyle = "#8cf524";
        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 240,15,15);
        ctx.fillRect(490, 240,15,15);
        // ctx.arc(490, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 240,15,15);
        ctx.fillRect(700, 240,15,15);
        // ctx.arc(600, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 370,15,15);
        ctx.fillRect(490, 370,15,15);
        // ctx.arc(490, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 370,15,15);
        ctx.fillRect(700, 370,15,15);
        // ctx.arc(600, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();
    }

    function DrawYellow() {
        ctx.fillStyle = "#f5f424";
        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 225,15,15);
        ctx.fillRect(490, 225,15,15);
        // ctx.arc(490, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 225,15,15);
        ctx.fillRect(700, 225,15,15);
        // ctx.arc(600, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();

        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 355,15,15);
        ctx.fillRect(490, 355,15,15);
        // ctx.arc(490, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 355,15,15);
        ctx.fillRect(700, 355,15,15);
        // ctx.arc(600, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();

    }

    function DrawRed() {
        ctx.fillStyle = "#f54b24";
        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 210,15,15);
        ctx.fillRect(490, 210,15,15);
        // ctx.arc(490, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 210,15,15);
        ctx.fillRect(700, 210,15,15);
        // ctx.arc(700, 240, 10, 0, 2 * Math.PI, true);
        ctx.closePath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 340,15,15);
        ctx.fillRect(490, 340,15,15);
        // ctx.arc(490, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();


        ctx.beginPath();

        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 340,15,15);
        ctx.fillRect(700, 340,15,15);
        // ctx.arc(700, 360, 10, 0, 2 * Math.PI, true);
        ctx.closePath();

    }

    function drawTrain(ctx, num) {            //draw train

      //  var time = Date.now();
if(num==0)
{
    ctx.clearRect(lPos, 270, 110, 59);
    var train = document.getElementById("trainL");
    // x = (time - startTime) / 10 % 1000;
    lPos=(lPos+1)%1200;
    ctx.drawImage(train,lPos, 270);

}
       else{
    ctx.clearRect(rPos, 270, 140, 59);
    var train = document.getElementById("trainR");
    // x = (time - startTime) / 10 % 1000;
    rPos=((rPos-1)+1200)%1200;
    ctx.drawImage(train,rPos, 270);

}
    }



    document.getElementById("runLeft").addEventListener("click", function() {
        rate++;
        drawL();
       // drawGate();
    }, false);
    document.getElementById("runRight").addEventListener("click", function() {
        rate++;
        drawR();
       // drawGate();
    }, false);

    document.getElementById("stop").addEventListener("click", function() {
        console.log(rate);
        if( stopMark) {
            window.cancelAnimationFrame(stopMark);
            stopMark = null;
        }


    }, false);



    function DrawLight()
    {
        ctx.fillStyle = "gray";
        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 210,15,45);
        ctx.fillRect(490, 210,15,45);
        ctx.closePath();

        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 210,15,45);
        ctx.fillRect(700, 210,15,45);
        ctx.closePath();

        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(490, 340,15,45);
        ctx.fillRect(490, 340,15,45);
        ctx.closePath();

        ctx.beginPath();
        ctx.strokeStyle="gray";
        ctx.strokeRect(700, 340,15,45);
        ctx.fillRect(700, 340,15,45);
        ctx.closePath();


    }

   function DrawShape(ctx)
    {
        ctx.fillStyle = "blue";
        ctx.fillRect(510, 255, 10, 10);
        ctx.fillRect(510, 335, 10, 10);
    }
    function DrawDline(ctx) {

        drawDashLine(ctx, 150, 50, 150, 550, 5);
        drawDashLine(ctx, 1050, 50, 1050, 550, 5);

        drawDashLine(ctx, 300, 50, 300, 550, 5);
        drawDashLine(ctx, 900, 50, 900, 550, 5);

        drawDashLine(ctx, 450, 50, 450, 550, 5);
        drawDashLine(ctx, 750, 50, 750, 550, 5);

        ctx.clearRect(0, 270, 1200, 60);
    }

    function DrawSline(ctx) {


//        ctx.lineWidth = 10;
//        //设置线的颜色
        ctx.strokeStyle = "dodgerblue";
//        ctx.moveTo(0,0);
//        ctx.strokeRect(0,0,1200,600);


        ctx.lineWidth = 2;
        //
        ctx.moveTo(0, 270);

        ctx.lineTo(1200, 270);
        //vertical line
        ctx.moveTo(520, 250);

        ctx.lineTo(520, 100);

        ctx.moveTo(680, 250);

        ctx.lineTo(680, 100);
        //
        ctx.moveTo(0, 330);

        ctx.lineTo(1200, 330);
        //vertical line
        ctx.moveTo(520, 350);

        ctx.lineTo(520, 500);

        ctx.moveTo(680, 350);

        ctx.lineTo(680, 500);

        //xiexian
        ctx.lineWidth = 1;
        ctx.moveTo(0,120);
        ctx.lineTo(150,270);

        ctx.moveTo(0,120+60*Math.sqrt(2));
        ctx.lineTo(150-60*Math.sqrt(2),270);

        ctx.moveTo(1050,270);
        ctx.lineTo(1200,120);

        ctx.moveTo(1050+60*Math.sqrt(2),270);
        ctx.lineTo(1200,120+60*Math.sqrt(2));




    }

    function drawDashLine(ctx, x1, y1, x2, y2, dashLength) {
        var dashLen = dashLength === undefined ? 5 : dashLength,
            xpos = x2 - x1, //得到横向的宽度;
            ypos = y2 - y1, //得到纵向的高度;
            numDashes = Math.floor(Math.sqrt(xpos * xpos + ypos * ypos) / dashLen);
        //利用正切获取斜边的长度除以虚线长度，得到要分为多少段;
        for(var i = 0; i < numDashes; i++) {
            if(i % 2 === 0) {
                ctx.moveTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
                //有了横向宽度和多少段，得出每一段是多长，起点 + 每段长度 * i = 要绘制的起点；
            } else {
                ctx.lineTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
            }
        }
        ctx.stroke();
    }
</script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" ;></script>;
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ; integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>

</html>