package com.swp.commons.logging.controller;

import com.github.pagehelper.PageHelper;
import com.swp.commons.logging.mapper.LoggingEventExceptionMapper;
import com.swp.commons.logging.mapper.LoggingEventMapper;
import com.swp.commons.logging.mapper.LoggingEventPropertyMapper;
import com.swp.commons.logging.model.LoggingEvent;
import com.swp.commons.logging.model.LoggingEventExample;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.MsgModel;
import com.swp.core.model.PageModel;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 描述:
 * 日志记录控制器
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-09-07 上午10:27
 */


@Controller
@RequestMapping("/commons/logging")
public class LoggingController extends BaseController {

    @MapperInject(LoggingEventMapper.class)
    private LoggingEventMapper eventMapper;

    @MapperInject(LoggingEventExceptionMapper.class)
    private LoggingEventExceptionMapper exceptionMapper;

    @MapperInject(LoggingEventPropertyMapper.class)
    private LoggingEventPropertyMapper propertyMapper;

    @RequestMapping("/manage")
    public String manage(){
        return "common/logging/manage";
    }

    /**
     * 获取日志列表
     *
     * @param offset
     * @param limit
     * @param search
     * @param sort
     * @param order
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public PageModel<LoggingEvent> list(int offset, int limit, String search, String sort, String order){
        PageHelper.offsetPage(offset,limit);

        LoggingEventExample example = new LoggingEventExample();
        example.setOrderByClause("timestmp desc");

        List<LoggingEvent> list = eventMapper.selectByExampleWithBLOBs(example);
        return new PageModel<>(list);
    }

    /**
     * 清空所有的日志记录
     *
     * @return
     */
    @RequestMapping(value = "/clear",method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public MsgModel clear(){
        eventMapper.deleteByExample(null);
        exceptionMapper.deleteByExample(null);
        propertyMapper.deleteByExample(null);
        return this.resultMsg("1","清空完成");
    }

}
