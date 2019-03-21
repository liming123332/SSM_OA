package mapperTest;

import com.ssm.oa.entity.SysOrg;
import com.ssm.oa.service.ISysOrgService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext-*.xml"})
public class ServiceTest {
    @Autowired
    private ISysOrgService sysOrgService;
    @Test
    public void test1(){
        SysOrg sysOrg = sysOrgService.selectByPrimaryKey(1L);
        System.out.println(sysOrg.getOrgName());

    }
}
