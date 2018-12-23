<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="infoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="bt"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">Notification</h4>
            </div>
            <div class="modal-body">
                <p id="msg"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.form.js"></script>
<script>
    $(function () {
        $("#theForm").ajaxForm({
            success:function (json, statusText, xhr, $form) {
                if (json.state == 'ok') {
                    if(json.url == 'close'){
                        window.close();
                    }
                    if(json.msg!=''){
                        $("#msg").html(json.msg);
                        $("#bt").attr("onclick","javascript:window.location.href='"+json.url+"'");
                        $("#close").attr("onclick","javascript:window.location.href='"+json.url+"'");
                        $('#infoModal').modal();
                    }else{
                        if(json.url!=''){
                            window.location.href=json.url;
                        }
                    }
                }
                else {
                    $("#msg").html(json.msg);
                    $('#infoModal').modal();
                }
            },
            dataType:'json'

        });
    })
</script>