package jdepend.core.score;

import jdepend.core.command.CommandAdapterMgr;
import jdepend.framework.exception.JDependException;
import jdepend.model.JDependUnitMgr;
import jdepend.model.result.AnalysisResult;

public final class ScoreUtil {

	public final static String ScoreAndResult = "ScoreAndResult";
	public final static String OnlyScoreMode = "OnlyScoreMode";

	public static void saveScore(AnalysisResult result, String mode) throws JDependException {
		ScoreInfo score = new ScoreInfo();

		score.group = CommandAdapterMgr.getCurrentGroup();
		score.command = CommandAdapterMgr.getCurrentCommand();
		score.lc = result.getSummary().getLineCount();
		score.score = result.getScore();
		score.d = result.getD();
		score.balance = result.getBalance();
		score.relation = result.getRelationRationality();
		score.oo = result.getSummary().getObjectOriented();
		score.encapsulation = result.getEncapsulation();

		if (ScoreAndResult.equals(mode)) {
			ScoreRepository.save(score, result);
		} else {
			ScoreRepository.save(score);
		}
	}

	public static void saveScore(String mode) throws JDependException {
		saveScore(JDependUnitMgr.getInstance().getResult(), mode);
	}

}
