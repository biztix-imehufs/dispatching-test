<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="esperMain" scope="session"	
class="BPMN_Simulation1.EsperMains"/>
<HTML>
<HEAD>
<TITLE>Progress</TITLE>
<script type="text/javascript">
    
    function popup(url) {
    var width = 300;
    var height = 200;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    var params = 'width=' + width + ', height=' + height;
    params += ', top=' + top + ', left=' + left;
    params += ', directories=no';
    params += ', location=no';
    params += ', menubar=no';
    params += ', resizable=no';
    params += ', scrollbars=no';
    params += ', status=no';
    params += ', toolbar=no';
    newwin = window.open(url, 'windowname5', params);
    return false;
}


//]]>
</script>

<% if (!esperMain.isCompleted()) { %>  
<SCRIPT LANGUAGE="JavaScript">
//setTimeout("location='TestingGraph.jsp'", 1000);
setTimeout(popup('TestingGraph.jsp'), 1000);
</SCRIPT> 
<% } %> 



<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta charset="utf-8">
<title>Dagre D3 Renderer Demo</title>
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="./realTest/dagre-d3.js"></script>

<style>

  body {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: 0;
    padding: 0;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serf;
    background: #999;
  }


  @-webkit-keyframes flash {
    0%, 50%, 100% {
      opacity: 1;
    }

    25%, 75% {
      opacity: 0.2;
    }
  }

  @keyframes flash {
    0%, 50%, 100% {
      opacity: 1;
    }

    25%, 75% {
      opacity: 0.2;
    }
  }

  .warn {
    -webkit-animation-duration: 5s;
    animation-duration: 5s;
    -webkit-animation-fill-mode: both;
    animation-fill-mode: both;
    -webkit-animation-iteration-count: 1;
    animation-iteration-count: 1;
  }

  .live.map {
    width: 100%;
    height: 100%;
  }

  svg {
    width: 100%;
    height: 100%;
    overflow: hidden;
  }

  .live.map text {
    font-weight: 300;
    font-size: 14px;
  }

  .live.map .node rect {
    stroke-width: 1.5px;
    stroke: #bbb;
    fill: #666;
  }

  .live.map .status {
    height: 100%;
    width: 15px;
    display: block;
    float: left;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
    margin-right: 4px;
  }

  .live.map .running .status {
    background-color: #7f7;
  }

  .live.map .running.warn .status {
    background-color: #ffed68;
  }

  .live.map .stopped .status {
    background-color: #f77;
  }

  .live.map .warn .queue {
    color: #f77;
  }

  .warn {
    -webkit-animation-name: flash;
    animation-name: flash;
  }

  .live.map .consumers {
    margin-right: 2px;
  }

  .live.map .consumers,
  .live.map .name {
    margin-top: 4px;
  }

  .live.map .consumers:after {
    content: "x";
  }

  .live.map .queue {
    display: block;
    float: left;
    width: 130px;
    height: 20px;
    font-size: 12px;
    margin-top: 2px;
  }

  .live.map .node g div {
    width: 200px;
    height: 40px;
    color: #fff;
  }

  .live.map .node g div span.consumers {
    display: inline-block;
    width: 20px;
  }

  .live.map .edgeLabel text {
    width: 50px;
    fill: #fff;
  }

  .live.map .edgePath path {
    stroke: #999;
    stroke-width: 1.5px;
    fill: #999;
  }
</style>



<!-- ending -->




</HEAD> 
<BODY> 
<% if (!esperMain.isCompleted()) { %>
<%//out.println(esperMain.getInt()); %> <br/> </html>
<% } else { %> 
<H1 ALIGN="CENTER">Put your page content here...</H1> 
<% } %> 


<!--  starting again -->

<div class="live map">
  <svg><g/></svg>
</div>

<script>

  var activity = <%=esperMain.getInt()%>;
  var activi = {
    "identifier": {
      "consumers": 2,
      "count": 20
    },
    "lost-and-found": {
      "consumers": 1,
      "count": 1,
      "inputQueue": "identifier",
      "inputThroughput": 50
    },
    "monitor": {
      "consumers": 1,
      "count": 0,
      "inputQueue": "identifier",
      "inputThroughput": 50
    },
    "meta-enricher": {
      "consumers": 4,
      "count": 9900,
      "inputQueue": "identifier",
      "inputThroughput": 50
    },
    "geo-enricher": {
      "consumers": 2,
      "count": 1,
      "inputQueue": "meta-enricher",
      "inputThroughput": 50
    },
    "elasticsearch-writer": {
      "consumers": 0,
      "count": 9900,
      "inputQueue": "geo-enricher",
      "inputThroughput": 50
    }
  };

  // Set up zoom support
  var svg = d3.select("svg"),
      inner = svg.select("g"),
      zoom = d3.behavior.zoom().on("zoom", function() {
        inner.attr("transform", "translate(" + d3.event.translate + ")" +
                                    "scale(" + d3.event.scale + ")");
      });
  svg.call(zoom);

  var render = new dagreD3.render();

  // Left-to-right layout
  var g = new dagreD3.graphlib.Graph();
  g.setGraph({
    nodesep: 70,
    ranksep: 50,
    rankdir: "LR",
    marginx: 20,
    marginy: 20
  });

  function draw(isUpdate) {
    for (var id in activity) {
      var act = activity[id];
      var className = act.consumers ? "running" : "stopped";
      if (act.count > 10000) {
        className += " warn";
      }
      var html = "<div>";
      html += "<span class=status></span>";
      html += "<span class=consumers>"+act.consumers+"</span>";
      html += "<span class=name>"+id+"</span>";
      html += "<span class=queue><span class=counter>"+act.count+"</span></span>";
      html += "</div>";
      g.setNode(id, {
        labelType: "html",
        label: html,
        rx: 5,
        ry: 5,
        padding: 0,
        class: className
      });

      if (act.inputQueue) {
        g.setEdge(act.inputQueue, id, {
          label: act.inputThroughput + "/s",
          width: 50
        });
      }
    }

    inner.call(render, g);

    // Zoom and scale to fit
    var zoomScale = zoom.scale();
    var graphWidth = g.graph().width + 50;
    var graphHeight = g.graph().height + 40;
    var width = parseInt(svg.style("width").replace(/px/, ""));
    var height = parseInt(svg.style("height").replace(/px/, ""));
    zoomScale = Math.min(width / graphWidth, height / graphHeight);
    var translate = [(width/2) - ((graphWidth*zoomScale)/2), (height/2) - ((graphHeight*zoomScale)/2)];
    zoom.translate(translate);
    zoom.scale(zoomScale);
    zoom.event(isUpdate ? svg.transition().duration(500) : d3.select("svg"));
  }

  // Do some mock queue status updates
  setInterval(function() {
    var stoppedWorker1Count = activity["elasticsearch-writer"].count;
    var stoppedWorker2Count = activity["meta-enricher"].count;
    for (var id in activity) {
      activity[id].count = Math.ceil(Math.random() * 3);
      if (activity[id].inputThroughput) activity[id].inputThroughput = Math.ceil(Math.random() * 250);
    }
    activity["elasticsearch-writer"].count = stoppedWorker1Count + Math.ceil(Math.random() * 100);
    activity["meta-enricher"].count = stoppedWorker2Count + Math.ceil(Math.random() * 100);
    draw(true);
  }, 1000);

  // Do a mock change of worker configuration
  setInterval(function() {
    activity["elasticsearch-monitor"] = {
      "consumers": 0,
      "count": 0,
      "inputQueue": "start",
      "inputThroughput": 50
    }
  }, 5000);
  <% if (!esperMain.isCompleted()) { %>  
  <SCRIPT LANGUAGE="JavaScript">
  setInterval(function() {
	  activity = <%=esperMain.getInt()%>;
	  draw(true);
	  }, 1000);
  </SCRIPT> 
  <% }%>
  }
  draw();
</script>

<!--  ending again -->
</BODY> 
</HTML> 