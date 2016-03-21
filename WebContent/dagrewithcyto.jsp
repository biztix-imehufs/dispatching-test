<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

	<head>
		<title>cytoscape-dagre.js demo</title>

		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">

		<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
		<script src="http://cytoscape.github.io/cytoscape.js/api/cytoscape.js-latest/cytoscape.min.js"></script>

		<!-- for testing with local version of cytoscape.js -->
		<!--<script src="../cytoscape.js/build/cytoscape.js"></script>-->

		<script src="https://cdn.rawgit.com/cpettitt/dagre/v0.7.4/dist/dagre.min.js"></script>
		<script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-dagre/1.1.2/cytoscape-dagre.js"></script>

		<style>
			body {
				font-family: helvetica;
				font-size: 14px;
			}

			#cy {
				width: 100%;
				height: 100%;
				position: absolute;
				left: 0;
				top: 0;
				z-index: 999;
			}

			h1 {
				opacity: 0.5;
				font-size: 1em;
			}
		</style>

		<script>
			$(function(){

				var cy = window.cy = cytoscape({
					container: document.getElementById('cy'),

          boxSelectionEnabled: false,
          autounselectify: true,

					layout: {
						name: 'dagre'
					},

					style: [
						{
							selector: 'node',
							style: {
								'content': 'data(id)',
								'text-opacity': 0.5,
								'text-valign': 'center',
								'text-halign': 'right',
								'background-color': '#11479e'
							}
						},

						{
							selector: 'edge',
							style: {
								'width': 4,
								'target-arrow-shape': 'triangle',
								'line-color': '#9dbaea',
								'target-arrow-color': '#9dbaea'
							}
						}
					],

					elements: {
						nodes: [
							{ data: { id: 'n0' } },
							{ data: { id: 'n1' } },
							{ data: { id: 'n2' } },
							{ data: { id: 'n3' } },
							{ data: { id: 'n4' } },
							{ data: { id: 'n5' } },
							{ data: { id: 'n6' } },
							{ data: { id: 'n7' } },
							{ data: { id: 'n8' } },
							{ data: { id: 'n9' } },
							{ data: { id: 'n10' } },
							{ data: { id: 'n11' } },
							{ data: { id: 'n12' } },
							{ data: { id: 'n13' } },
							{ data: { id: 'n14' } },
							{ data: { id: 'n15' } },
							{ data: { id: 'n16' } }
						],
						edges: [
							{ data: { source: 'n0', target: 'n1' } },
							{ data: { source: 'n1', target: 'n2' } },
							{ data: { source: 'n1', target: 'n3' } },
							{ data: { source: 'n4', target: 'n5' } },
							{ data: { source: 'n4', target: 'n6' } },
							{ data: { source: 'n6', target: 'n7' } },
							{ data: { source: 'n6', target: 'n8' } },
							{ data: { source: 'n7', target: 'n8' } },
							{ data: { source: 'n8', target: 'n9' } },
							{ data: { source: 'n8', target: 'n10' } },
							{ data: { source: 'n11', target: 'n12' } },
							{ data: { source: 'n12', target: 'n13' } },
							{ data: { source: 'n13', target: 'n14' } },
							{ data: { source: 'n13', target: 'n15' } },
						]
					},
				});

			});
		</script>
	</head>

	<body>
		<h1>cytoscape-dagre demo</h1>

		<div id="cy"></div>

	</body>

</html>