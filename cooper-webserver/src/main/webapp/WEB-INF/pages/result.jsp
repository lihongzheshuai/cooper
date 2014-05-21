<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${ctx}/styles/css/pa_ui.css">
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="row-fluid">
				<div class="span12">
					<h3>您分析的jar为：${result.runningContext.path}</h3>
					<h3>
						您将jar分成了${result.summary.componentCount}个组件进行分析，其结构质量成绩为：${result.score}
					</h3>
					<h6>
						(其中类数量为${result.summary.classCount}，包数量为${result.summary.javaPackageCount})
					</h6>
					<h6>
						${result.summary.componentCount}个组件共产生了${result.summary.relationCount}个关系，有问题的关系占总关系的比例为${result.problemRelationScale}
					</h6>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span6">
					<h4>抽象程度合理性得分：${result.d}</h4>
					<h6>${result.DAdvise}</h6>
					<div id="d" class="d" style="height:400px"></div>
				</div>
				<div class="span6">
					<h4>内聚性得分：${result.balance}</h4>
					<h6>${result.balanceAdvise}</h6>
					<div id="balance" class="balance" style="height:400px"></div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span6">
					<h4>封装性得分：${result.encapsulation}</h4>
					<h6>${result.encapsulationAdvise}</h6>
					<div id="encapsulation" class="encapsulation" style="height:400px"></div>
				</div>
				<div class="span6">
					<h4>关系合理性得分：${result.relationRationality}</h4>
					<h6>${result.relationRationalityAdvise}</h6>
					<div id="relationRationality" class="relationRationality"
						style="height:400px"></div>
				</div>
			</div>
		</div>
		<c:if test="${!empty result.components}">
			<div class="row-fluid">
				<div class="span12">
					<h3>组件信息：</h3>
					<div
						style="overflow-x: auto; overflow-y: auto; height: 350px; width:100%; border: 1px solid #dddddd; ">
						<table class="table table-bordered" pa_ui_name="table,exinput"
							pa_ui_hover="true" pa_ui_selectable="true"
							pa_ui_select_mode="multi" pa_ui_select_trigger="tr"
							pa_ui_select_column="0" pa_ui_select_triggerelement=":checkbox">
							<thead>
								<tr>
									<th>选择</th>
									<th>组件名称</th>
									<th>代码行数</th>
									<th>类数量</th>
									<th>具体类数量</th>
									<th>抽象类数量</th>
									<th>传入</th>
									<th>传出</th>
									<th>抽象程度</th>
									<th>易变性</th>
									<th>稳定性</th>
									<th>抽象程度合理性</th>
									<th>耦合值</th>
									<th>内聚值</th>
									<th>内聚性</th>
									<th>封装性</th>
								</tr>
							</thead>
							<tbody id="listComponents">
								<c:forEach items="${summarys}" var="item">
									<tr>
										<td><input type="checkbox" /></td>
										<td class="itemName">${item.name}</td>
										<td>${item.lineCount}</td>
										<td>${item.classCount}</td>
										<td>${item.abstractClassCount}</td>
										<td>${item.concreteClassCount}</td>
										<td>${item.afferentCoupling}</td>
										<td>${item.efferentCoupling}</td>
										<td><fmt:formatNumber value="${item.abstractness}"
												pattern="#.###" /></td>
										<td><fmt:formatNumber value="${item.volatility}"
												pattern="#.###" /></td>
										<td><fmt:formatNumber value="${item.stability}"
												pattern="#.###" /></td>
										<td><fmt:formatNumber value="${item.distance}"
												pattern="#.###" /></td>
										<td><fmt:formatNumber value="${item.coupling}"
												pattern="###,###.##" /></td>
										<td><fmt:formatNumber value="${item.cohesion}"
												pattern="###,###.##" /></td>
										<td><fmt:formatNumber value="${item.balance}"
												pattern="#.###" /></td>
										<td><fmt:formatNumber value="${item.encapsulation}"
												pattern="#.###" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty relations}">
			<div class="row-fluid">
				<div class="span12">
					<h3>关系信息：</h3>
					<div
						style="overflow-x: auto; overflow-y: auto; height: 350px; width:100%; border: 1px solid #dddddd; ">
						<table class="table table-bordered" pa_ui_name="table,exinput"
							pa_ui_hover="true" pa_ui_selectable="true"
							pa_ui_select_mode="multi" pa_ui_select_trigger="tr"
							pa_ui_select_column="0" pa_ui_select_triggerelement=":checkbox">
							<thead>
								<tr>
									<th>选择</th>
									<th>当前组件</th>
									<th>依赖组件</th>
									<th>关系强度</th>
									<th>当前组件内聚性</th>
									<th>依赖组件内聚性</th>
									<th>关系平衡值</th>
									<th>关注类型</th>
									<th>关注级别</th>
								</tr>
							</thead>
							<tbody id="listRelations">
								<c:forEach items="${relations}" var="item">
									<tr>
										<td><input type="checkbox" /></td>
										<td>${item.current.name}</td>
										<td>${item.depend.name}</td>
										<td><fmt:formatNumber value="${item.intensity}"
												pattern="###,###.##" /></td>
										<td><fmt:formatNumber
												value="${item.current.component.cohesion}"
												pattern="###,###.##" /></td>
										<td><fmt:formatNumber
												value="${item.depend.component.cohesion}"
												pattern="###,###.##" /></td>
										<td><fmt:formatNumber value="${item.balance}"
												pattern="###,###.##" /></td>
										<td>${item.attentionTypeName}</td>
										<td><fmt:formatNumber value="${item.attentionLevel}"
												pattern="##.###" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty tableList}">
			<div class="row-fluid">
				<div class="span12">
					<h3>待做事项：</h3>
					<div
						style="overflow-x: auto; overflow-y: auto; height: 350px; width:100%; border: 1px solid #dddddd; ">
						<table class="table table-bordered" pa_ui_name="table,exinput"
							pa_ui_hover="true" pa_ui_selectable="true"
							pa_ui_select_mode="multi" pa_ui_select_trigger="tr"
							pa_ui_select_column="0" pa_ui_select_triggerelement=":checkbox">
							<thead>
								<tr>
									<th>选择</th>
									<th>描述</th>
									<th>依据</th>
								</tr>
							</thead>
							<tbody id="listTodos">
								<c:forEach items="${todoList}" var="item">
									<tr>
										<td><input type="checkbox" /></td>
										<td>${item.content}</td>
										<td>${item.according}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty tableList}">
			<div class="row-fluid">
				<div class="span12">
					<h3>数据库表操作：</h3>
					<div
						style="overflow-x: auto; overflow-y: auto; height: 350px; width:100%; border: 1px solid #dddddd; ">
						<table class="table table-bordered" pa_ui_name="table,exinput"
							pa_ui_hover="true" pa_ui_selectable="true"
							pa_ui_select_mode="multi" pa_ui_select_trigger="tr"
							pa_ui_select_column="0" pa_ui_select_triggerelement=":checkbox">
							<thead>
								<tr>
									<th>选择</th>
									<th>表名</th>
									<th>出现次数</th>
									<th>操作</th>
									<th>组件名</th>
									<th>类名</th>
								</tr>
							</thead>
							<tbody id="listTables">
								<c:forEach items="${tableList}" var="item">
									<tr>
										<td><input type="checkbox" /></td>
										<td>${item.name}</td>
										<td>${item.count}</td>
										<td>${item.type}</td>
										<td>${item.component}</td>
										<td>${item.javaClass}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty result.relations}">
			<div class="row-fluid">
				<div class="span12">
					<h3>组件关系图：</h3>
					<div id="relationGraph" class="relationGraph" style="height:500px"></div>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty structure_tip}">
			<div class="row-fluid">
				<div class="span12">
					<h3>结构提示：</h3>
					<textarea rows="15" style="width:100%">${structure_tip}</textarea>
				</div>
			</div>
		</c:if>
	</div>
</div>
<script language="javascript" type="text/javascript"
	src="${ctx}/styles/js/pa_ui.js"></script>
<script language="javascript" type="text/javascript"
	src="${ctx}/styles/js/esl.js"></script>
<script type="text/javascript">
    // 路径配置
    require.config({
        paths:{ 
            'echarts' : '${ctx}/styles/js/echarts',
            'echarts/chart/map' : '${ctx}/styles/js/echarts-map'
        }
    });
    
    // 使用
    require(
        [
            'echarts',
            'echarts/chart/map'
        ],
        function(ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById('relationGraph')); 
            
            option = {
            	    title : {
            	        x:'right',
            	        y:'bottom'
            	    },
            	    tooltip : {
            	        trigger: 'item',
            	        formatter: '{a} : {b}'
            	    },
            	    legend: {
            	        x: 'left',
            	    },
            	    series : [
            	        {
            	            type:'force',
            	            name : "组件关系",
            	            categories : [
            	                {
            	                    name: '组件',
            	                    itemStyle: {
            	                        normal: {
            	                            color : '#87cdfa'
            	                        }
            	                    }
            	                }
            	            ],
            	            itemStyle: {
            	                normal: {
            	                    label: {
            	                        show: true,
            	                        textStyle: {
            	                            color: '#800080'
            	                        }
            	                    },
            	                    nodeStyle : {
            	                        brushType : 'both',
            	                        strokeColor : 'rgba(255,215,0,0.4)',
            	                        lineWidth : 1
            	                    }
            	                },
            	                emphasis: {
            	                    label: {
            	                        show: false
            	                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
            	                    },
            	                    nodeStyle : {
            	                        //r: 30
            	                    },
            	                    linkStyle : {}
            	                }
            	            },
            	            minRadius : 15,
            	            maxRadius : 25,
            	            density : 0.05,
            	            attractiveness: 1.2,
            	            linkSymbol: 'arrow',
            	            nodes: ${relation_graph_data.nodeInfo},
            	            links: ${relation_graph_data.edgeInfo}
            	        }
            	    ]
            	};
            	var ecConfig = require('echarts/config');
            	function focus(param) {
            	    var data = param.data;
            	    var links = option.series[0].links;
            	    var nodes = option.series[0].nodes;
            	    if (
            	        data.source !== undefined
            	        && data.target !== undefined
            	    ) { //点击的是边
            	        var sourceNode = nodes[data.source];
            	        var targetNode = nodes[data.target];
            	        console.log("选中了边 " + sourceNode.name + ' -> ' + targetNode.name + ' (' + data.weight + ')');
            	    } else { // 点击的是点
            	        console.log("选中了" + data.name + '(' + data.value + ')');
            	    }
            	    console.log(param);
            	}
            	myChart.on(ecConfig.EVENT.CLICK, focus);
            	myChart.setOption(option, true);
            	
            	myChart = ec.init(document.getElementById('d')); 
            	option = {
            		    tooltip : {
            		        trigger: 'item',
            		        formatter: "{a} <br/>{b} : {c} ({d}%)"
            		    },
            		    series : [
            		        {
            		            type:'pie',
            		            data:[
            		                {value:${result.d}, name:'得分'},
            		                {value:25 - ${result.d}, name:'未得分'},
            		            ]
            		        }
            		    ],
            		    color : [
							'#69D2E7', '#E0E4CC'
            		    ]
            		};
            	myChart.setOption(option, true);
            	
            	myChart = ec.init(document.getElementById('balance')); 
            	option = {
            		    tooltip : {
            		        trigger: 'item',
            		        formatter: "{a} <br/>{b} : {c} ({d}%)"
            		    },
            		    series : [
            		        {
            		            type:'pie',
            		            data:[
            		                {value:${result.balance}, name:'得分'},
            		                {value:25 - ${result.balance}, name:'未得分'},
            		            ]
            		        }
            		    ],
            		    color : [
							'#69D2E7', '#E0E4CC'
            		    ]
            		};
            	myChart.setOption(option, true);
            	
            	myChart = ec.init(document.getElementById('encapsulation')); 
            	option = {
            		    tooltip : {
            		        trigger: 'item',
            		        formatter: "{a} <br/>{b} : {c} ({d}%)"
            		    },
            		    series : [
            		        {
            		            type:'pie',
            		            data:[
            		                {value:${result.encapsulation}, name:'得分'},
            		                {value:25 - ${result.encapsulation}, name:'未得分'},
            		            ]
            		        }
            		    ],
            		    color : [
							'#69D2E7', '#E0E4CC'
            		    ]
            		};
            	myChart.setOption(option, true);
            	
            	myChart = ec.init(document.getElementById('relationRationality')); 
            	option = {
            		    tooltip : {
            		        trigger: 'item',
            		        formatter: "{a} <br/>{b} : {c} ({d}%)"
            		    },
            		    series : [
            		        {
            		            type:'pie',
            		            data:[
            		                {value:${result.relationRationality}, name:'得分'},
            		                {value:25 - ${result.relationRationality}, name:'未得分'},
            		            ]
            		        }
            		    ],
            		    color : [
							'#69D2E7', '#E0E4CC'
            		    ]
            		};
            	myChart.setOption(option, true);
        }
    );
</script>