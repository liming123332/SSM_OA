package com.ssm.oa.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.dto.TaskDto;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.utils.Result;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.util.json.JSONObject;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/task")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @RequestMapping("/show")
    public String show(){
        return "/task/taskList";
    }

    @RequestMapping("/select")
    @ResponseBody
    public Result select(Integer pn, Integer pageSize){
        Subject subject = SecurityUtils.getSubject();
        SysUser sysUser = (SysUser) subject.getPrincipal();
        int startIndex=(pn-1)*pageSize;

        List<Task> list = taskService.createTaskQuery().taskAssignee(sysUser.getUserId().toString()).listPage(startIndex,pageSize);

        List<Task> list2 = taskService.createTaskQuery().taskAssignee(sysUser.getUserId().toString()).list();

        List<TaskDto> taskDtoList=new ArrayList<>();
        for (Task task : list) {
            TaskDto taskDto=new TaskDto();
            taskDto.setID(task.getId());
            taskDto.setDate(task.getCreateTime());
            taskDto.setName(task.getName());
            taskDto.setProcessInstanceId(task.getProcessInstanceId());
            taskDtoList.add(taskDto);
        }
        Result result=new Result(200, taskDtoList, list2.size());
        return result;
    }
}
