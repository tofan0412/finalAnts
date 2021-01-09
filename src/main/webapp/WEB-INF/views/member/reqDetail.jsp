<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<title>협업관리프로젝트</title>

	<script type="text/javascript">
		$(function(){
			donutChartproper();
			chartproday();
			
			
		});
		
		/* 전체 프로젝트 진행사항 */
		function donutChartproper() {
		$.ajax({
			url : "/project/donutChartproper",
			method : "get",
			success : function(data) {
				var dpercent=[];
				dpercent.push(data.projectVo.percent);
				var a=data.projectVo.percent*1;
				var c = 100-a+0;
				var d = c+"";
				dpercent.push(d);
				var donutChartData = {
						labels : ['완료','진행'],
						 datasets: [
						        {
						          data: dpercent,
						          backgroundColor : ['#87C488', '#869DAB'],
						        }
						      ]
				};
				 var donutOptions     = {
					      maintainAspectRatio : false,
					      responsive : true,
					    }
				var dctx = document.getElementById('donutChartproper').getContext('2d');
				var donutChart = new Chart(dctx, {
				      type: 'doughnut',
				      data: donutChartData,
				      options: donutOptions
				    });
				}
			});
		}		
		
		/* 일별 진행도 */
		function chartproday() {
			$.ajax({
				url : "/project/chartproday",
				method : "get",
				success : function(data) {
					var num = [];
					var percent=[];
					for(i=0; i<data.dbsize; i++){
					num.push(data.projectList[i].regDt);	
					percent.push(data.projectList[i].percent);
					}
					var lineChartData = {
							labels : num,
							 datasets: [
							        {
							          label               : '일별 진행도',
							          backgroundColor     : '#1D6A96',
							          borderColor         : '#1D6A96',
							          pointRadius          : false,
							          pointColor          : '#1D6A96',
							          pointStrokeColor    : '#1D6A96',
							          pointHighlightFill  : '#fff',
							          pointHighlightStroke: '#1D6A96',
							          data                : percent
							        }]
					};
					 var lineChartOptions     = {
							 responsive              : true,
						      maintainAspectRatio     : false,
						      datasetFill  			  : false,
						      scales: {
							        xAxes: [{
							          display : true
							        }],
							        yAxes: [{
							        	ticks: {
							                  stepSize: 10,
							                  suggestedMax: 50, 
							                  beginAtZero: true
							          }
							        }]
							      }
						    };
					var dctx = document.getElementById('chartproday').getContext('2d');
					var lineChart = new Chart(dctx, {
						  type: 'line',
						  data: lineChartData,
						  options: lineChartOptions
					    });
					}
				});
		}
		
		/* 요구사항정의서 수정페이지보기 */
		function reqUpdate() {
			document.DetailForm.action = "<c:url value = '/req/reqUpdateView'/>";
			document.DetailForm.submit();
		}
	</script>

	<form:form commandName="reqVo" id="DetailForm" name="DetailForm" method="post">
		<form:hidden path="reqId"/>
		
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">요구사항 정의서</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">요구사항 정의서</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    		<!-- Main content -->
		    <section class="content">
		      <!-- Default box -->
		      <div class="card jg">
		        <div class="card-header">
		          <c:if test="${reqVo.proName != null }">
			          <a class="jg" href="/project/pmProjectgetReq?reqId=${reqVo.reqId }" style="color: #0BB783;">프로젝트 공간으로 가시겠습니까?</a>
		          </c:if>
		
		          <div class="card-tools">
		            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
		              <i class="fas fa-minus"></i>
		            </button>
		            
		          </div>
		        </div>
		        <div class="card-body">
		          <div class="row">
		            <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
		              <div class="row" style="margin-bottom: 10px;">
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">예상 기간</span>
		                      <span class="info-box-number text-center text-muted mb-0">${reqVo.reqPeriod }일</span>
		                    </div>
		                  </div>
		                </div>
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">Project Leader </span>
		                      <span class="info-box-number text-center text-muted mb-0">
		                      	<c:choose>
			                  		<c:when test="${reqVo.status eq 'ACCEPT' }">${reqVo.plName }</c:when>
			                  		<c:otherwise>-</c:otherwise>
		                  		</c:choose>
		                      </span>
		                    </div>
		                  </div>
		                </div>
		                <div class="col-12 col-sm-4">
		                  <div class="info-box bg-light">
		                    <div class="info-box-content">
		                      <span class="info-box-text text-center text-muted">진행 상태</span>
		                      <span class="info-box-number text-center text-muted mb-0">
		                      	<c:choose>
		                      		<c:when test="${reqVo.proStatus eq 'ACTIVE'}">진행중</c:when>
		                      		<c:when test="${reqVo.proStatus eq 'STOP'}">일시정지</c:when>
		                      		<c:when test="${reqVo.proStatus eq 'END'}">종료</c:when>
		                      		<c:otherwise>-</c:otherwise>
		                      	</c:choose>
		                      
		                      </span>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="row">
		                <div class="col-12 col-sm-4">
		                  <h5>구성원</h5>
		                  	<c:choose>
		                    	<c:when test="${promemListIn.size() > 0 }">
				                  <c:forEach items="${promemListIn }" var="pmem" begin="0" end="4">
				                    <div class="post" style="border: none;">
				                      <div class="user-block">
				                      	<c:if test="${fn:substring(pmem.memFilepath,0 ,1) eq '/' }">									
											<img id="imge" style="width: 40px; height:  40px; border-radius: 50%; border: 2px solid #adb5bd;"  src="${pmem.memFilepath}" />
										</c:if>
										<c:if test="${fn:substring(pmem.memFilepath,0 ,2) eq 'D:' }">		
											<img id="pict" style="width:  40px; height:  40px;  border-radius: 50%; border: 2px solid #adb5bd;" src="/profileImgView?memId=${pmem.memId}" />
										</c:if>
<%-- 					                  	<img class="img-circle img-bordered-sm pictureViewImg" src="/profileImgView?memId=${pmem.memId }" alt="user image"> --%>
				                        <span class="username">
				                          <a href="/member/profile?memId=${pmem.memId }">${pmem.memName }</a>
				                        </span>
				                        <span class="description">${pmem.memId }</span>
				                      </div>
				                    </div>
				                  </c:forEach>
		                    	</c:when>
		                      	<c:otherwise>-</c:otherwise>
		                    </c:choose>
		                  <c:if test="${promemListIn.size() > 5 }">
		                  	<div class="col-12 col-sm-6 float-right">
		                  		<a class="btn btn-default btn-sm" data-toggle="modal" data-target="#allpromem">... 더보기</a>
		                  	</div>
		                  </c:if>
		                </div>
		                <div class="col-12 col-sm-7">
		                    <div class="tab-content" id="custom-tabs-three-tabContent">
		                      <div class="tab-pane fade active show" id="custom-tabs-three-work" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab">
		                      	<div class="bani_div">
		                          <h5 class="baniChart">프로젝트 진행도 </h5><br>
		                          <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
			              		 	<canvas id="donutChartproper" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 815px;" width="815" height="250" class="chartjs-render-monitor"></canvas>
			              		  </div>
			              		</div>
			              		<div class="bani_div">
				              		<h5 class="baniChart">일별 프로젝트 진행율 </h5><br>
			                        <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
				              		 	<canvas id="chartproday" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 815px;" width="815" height="350" class="chartjs-render-monitor"></canvas>
			                        </div>
		                        </div>
		                      </div>
		                    </div>
		                </div>
		              </div>
		            </div>
		            <!-- 요구사항정의서 title, content -->
		            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
		              <h3 class="text-primary" ><i class="fas fa-paint-brush"></i> ${reqVo.reqTitle }</h3>
		              <p class="text-muted">${reqVo.reqCont }</p>
		              <br> 
		              <div class="text-muted">
		                <p class="text-sm">Project Leader
		                  <b class="d-block">
		                  	<c:choose>
			                  	<c:when test="${reqVo.status eq 'ACCEPT' }">${reqVo.plName }</c:when>
			                  	<c:otherwise>-</c:otherwise>
		                  	</c:choose>
		                  </b>
		                </p>
		              </div>
						
					<!-- 파일 목록 -->
		              <h5 class="mt-5 text-muted">요구사항 정의서 파일</h5>
		              <ul class="list-unstyled">
		              	<c:if test="${filelist.size() == 0}">
							[ 첨부파일이 없습니다. ]
						</c:if>
						
						<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" >
						  <li>
							<c:choose>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'png' or fn:toLowerCase(files.pubExtension) eq 'jpg'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-fw fa-image "></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'pdf'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-pdf"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'docx'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-archive"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'pptx'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-powerpoint"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'zip'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-archive"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'zip'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-archive"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:when test="${fn:toLowerCase(files.pubExtension) eq 'xlsx' or fn:toLowerCase(file.pubExtension) eq 'xls'}">
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file-excel"></i>&nbsp;${files.pubFilename }
									</a>
								</c:when>
								<c:otherwise>
									<a href="${cp }/file/publicfileDown?pubId=${files.pubId}" class="btn-link text-secondary">
										<i class="far fa-file"></i>&nbsp;${files.pubFilename }
									</a>
								</c:otherwise>
								
							</c:choose>
						  </li>
		                </c:forEach>
		              </ul>
		              <c:if test="${SMEMBER.memType == 'PM' }">
			              <div class="text-center mt-5 mb-3">
			                <a href="javascript:reqUpdate();" class="btn btn-sm btn-primary">파일 추가</a>
			              </div>
		              </c:if>
		            </div>
		          </div>
		        </div>
		        <!-- /.card-body -->
		        <c:if test="${SMEMBER.memType == 'PM' }">
			        <div class="card-footer">
				        <a href="/req/reqList" class="btn btn-secondary" id="back">목록</a>
			        </div>
		        </c:if>
		      </div>
		      <!-- /.card -->
		
		    </section>
	</form:form>
	<div class="modal fade" id="allpromem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-lg" role="document" style="min-width: fit-content;">
			<div class="modal-content" style="height: 500px;">
				<div class="modal-header">
					<h3 class="modal-title jg" id="addplLable">전체 구성원</h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12 col-sm-4">
							<c:forEach items="${promemListIn }" var="pmem" varStatus="i">
					            <div class="post" style="border: none;">
					              <div class="user-block">
					              	<c:if test="${fn:substring(pmem.memFilepath,0 ,1) eq '/' }">									
										<img id="imge" style="width: 40px; height:  40px; border-radius: 50%; border: 2px solid #adb5bd;"  src="${pmem.memFilepath}" />
									</c:if>
									<c:if test="${fn:substring(pmem.memFilepath,0 ,2) eq 'D:' }">		
										<img id="pict" style="width:  40px; height:  40px;  border-radius: 50%; border: 2px solid #adb5bd;" src="/profileImgView?memId=${pmem.memId}" />
									</c:if>
<%-- 						          	<img class="img-circle img-bordered-sm pictureViewImg" src="/profileImgView?memId=${pmem.memId }" alt="user image"> --%>
					                <span class="username">
					                  <a href="#">${pmem.memName }</a>
					                </span>
					                <span class="description">${pmem.memId }</span>
					              </div>
					            </div>
					 			<c:if test="${i.index%5 == 0 and i.index != 0}">
					 				</div>
					 				<div class="col-12 col-sm-4">
					 			</c:if>
				            </c:forEach>
			            </div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
</body>
</html>
