package com.swp.commons.logging.mapper;

import com.swp.commons.logging.model.LoggingEventProperty;
import com.swp.commons.logging.model.LoggingEventPropertyExample;
import com.swp.commons.logging.model.LoggingEventPropertyKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface LoggingEventPropertyMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    long countByExample(LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int deleteByExample(LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int deleteByPrimaryKey(LoggingEventPropertyKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int insert(LoggingEventProperty record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int insertSelective(LoggingEventProperty record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    List<LoggingEventProperty> selectByExampleWithBLOBs(LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    List<LoggingEventProperty> selectByExample(LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    LoggingEventProperty selectByPrimaryKey(LoggingEventPropertyKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int updateByExampleSelective(@Param("record") LoggingEventProperty record, @Param("example") LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int updateByExampleWithBLOBs(@Param("record") LoggingEventProperty record, @Param("example") LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int updateByExample(@Param("record") LoggingEventProperty record, @Param("example") LoggingEventPropertyExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int updateByPrimaryKeySelective(LoggingEventProperty record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table logging_event_property
     *
     * @mbg.generated Fri Sep 07 10:31:39 CST 2018
     */
    int updateByPrimaryKeyWithBLOBs(LoggingEventProperty record);
}