import org.antlr.v4.runtime.ParserRuleContext;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.snt.inmemantlr.GenericParser;
import org.snt.inmemantlr.exceptions.CompilationException;
import org.snt.inmemantlr.exceptions.IllegalWorkflowException;
import org.snt.inmemantlr.exceptions.ParsingException;
import org.snt.inmemantlr.listener.DefaultTreeListener;

import java.io.File;
import java.io.FileNotFoundException;

public class TestSmt2 {

    final static Logger LOGGER = LoggerFactory.getLogger(TestSmt2.class);

    private static GenericParser gp = null;

    private static DefaultTreeListener dlist = null;


    @Test
    public void testParser() {

        String gfile = TestSmt2.class.getClassLoader().getResource
                ("SMTLIBv2Parser.g4")
                .getFile();

        File f = new File(gfile);
        try {
            gp = new GenericParser(f);
        } catch (FileNotFoundException e) {
            LOGGER.debug(e.getMessage());
            System.exit(-1);
        }

        dlist = new DefaultTreeListener();

        gp.setListener(dlist);
        try {
            gp.compile();
        } catch (CompilationException e) {
            LOGGER.error(e.getMessage());
            Assert.assertFalse(true);
        }

        File base = new File(TestSmt2.class
                .getClassLoader()
                .getResource("examples").getFile());


        for (File fil : base.listFiles()) {
            try {
                ParserRuleContext pctx = gp.parse(fil, "start", GenericParser
                        .CaseSensitiveType.NONE);

            } catch (IllegalWorkflowException |
                    ParsingException | FileNotFoundException e) {
                LOGGER.error("error while parsing {}: {}", fil.getName(), e
                        .getMessage
                                ());
                Assert.assertTrue(false);
            }
            LOGGER.info("successfully parsed {}", fil);
            LOGGER.debug("file {}", dlist.getAst().toDot());
        }


    }


}
