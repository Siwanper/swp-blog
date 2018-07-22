package com.swp.core.persistence;

import com.github.pagehelper.PageHelper;
import com.swp.core.model.PageModel;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;

import java.util.List;

/**
 * 自定义的代理mapper，实现常规的CRUD操作
 *
 */
public class DelegateMapper {

    /**
     * mybatis 中的 sqlSessionTemplate ,在spring-mybatis配置文件中
     */
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 构造方法
     *
     * @param sqlSessionTemplate
     */
    public DelegateMapper(SqlSessionTemplate sqlSessionTemplate) {
        super();
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    // 查询方法
    /**
     * 无参数单个对象查询
     * @param statement 对应 sqlMapper 模版中的单个对象查询 sql 语句的映射名
     * @param <T>
     * @return
     */
    public <T> T selectOne(String statement) { return this.sqlSessionTemplate.selectOne(statement);}

    /**
     * 带参数的单个对象查询
     * @param statement
     * @param parameter
     * @param <T>
     * @return
     */
    public <T> T selectOne(String statement, Object parameter) {
        return  this.sqlSessionTemplate.selectOne(statement,parameter);
    }

    /**
     * 无参数查询对象集合
     * @param statement
     * @param <T>
     * @return
     */
    public <T> List<T> selectList(String statement) {
        return this.sqlSessionTemplate.selectList(statement);
    }

    /**
     * 带参数查询对象集合
     * @param statement
     * @param parameter
     * @param <T>
     * @return
     */
    public <T> List<T> selectList(String statement, Object parameter) {
        return this.sqlSessionTemplate.selectList(statement,parameter);
    }

    /**
     * 带参数查询对象集合（并带有条数范围）
     * @param statment
     * @param parameter
     * @param rowBounds
     * @param <T>
     * @return
     */
    public <T> List<T> selectList(String statment, Object parameter, RowBounds rowBounds) {
        return this.sqlSessionTemplate.selectList(statment, parameter, rowBounds);
    }

    /**
     * 无参分页查询，返回Page 分页对象
     * @param statement
     * @param offset 分页起始数量
     * @param limit 分页限制条数
     * @param <T>
     * @return PageModel<T> 分页结果集，自定义的 PageModel 墨香</>
     */
    public <T> PageModel<T> selectPagination(String statement, int offset, int limit) {
        return new PageModel<>(PageHelper.offsetPage(offset, limit).doSelectPage(() -> this.sqlSessionTemplate.selectList(statement)));
    }

    /**
     * 带参数分页查询，返回Page 分页对象
     * @param statement
     * @param parameter
     * @param offset
     * @param limit
     * @param <T>
     * @return
     */
    public <T> PageModel<T> selectPagination(String statement, Object parameter, int offset, int limit) {
        return new PageModel<>(PageHelper.offsetPage(offset, limit).doSelectPage(() -> this.sqlSessionTemplate.selectList(statement, parameter)));
    }

    // 增加方法
    /**
     * 无参增加方法
     * @param statement
     * @return 增加成功的条数
     */
    public int insert(String statement) {return this.sqlSessionTemplate.insert(statement);}

    /**
     * 带参增加方法
     * @param statement
     * @param parameter
     * @return
     */
    public int insert(String statement, Object parameter) {
        return this.sqlSessionTemplate.insert(statement, parameter);
    }

    // 修改方法

    /**
     * 无参修改方法
     * @param statement
     * @return 修改成功的条数
     */
    public int update(String statement) {
        return this.sqlSessionTemplate.update(statement);
    }

    /**
     * 带参修改方法
     * @param statement
     * @param parameter
     * @return
     */
    public int update(String statement, Object parameter){
        return this.sqlSessionTemplate.update(statement, parameter);
    }

    // 删除

    /**
     * 无参数删除方法
     * @param statement
     * @return
     */
    public int delete(String statement) {
        return this.sqlSessionTemplate.delete(statement);
    }

    /**
     * 带参数删除方法
     * @param statement
     * @param parameter
     * @return
     */
    public  int delete(String statement, Object parameter) {
        return this.sqlSessionTemplate.delete(statement, parameter);
    }
}
