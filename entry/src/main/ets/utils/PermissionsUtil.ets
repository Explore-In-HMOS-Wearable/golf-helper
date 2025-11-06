import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const domain = 0x0000;

class PermissionsUtil {
  private static instance: PermissionsUtil;

  static getInstance(): PermissionsUtil {
    if (!PermissionsUtil.instance) {
      PermissionsUtil.instance = new PermissionsUtil();
      hilog.info(domain, 'PermissionsUtil', 'Singleton instance created.');
    }
    return PermissionsUtil.instance;
  }

  async checkPermissions(permissions: Array<Permissions>): Promise<void> {
    let applyResult = false;
    for (let permission of permissions) {
      const grantStatus = await this.checkAccessToken(permission);
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        hilog.info(domain, 'PermissionsUtil', 'CheckPermission is granted');
        applyResult = true;
      } else {
        hilog.info(domain, 'PermissionsUtil', 'CheckPermission is not granted');
        applyResult = false;
      }
    }
    if (!applyResult) {
      this.requestPermissions(permissions);
    }
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    const atManager = abilityAccessCtrl.createAtManager();
    let grantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;
    let tokenId = 0;

    try {
      const bundleInfo = await bundleManager.getBundleInfoForSelf(
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION
      );
      tokenId = bundleInfo.appInfo.accessTokenId;
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(domain, 'PermissionsUtil', `Failed to get bundle info. Code: ${err.code}, message: ${err.message}`);
    }

    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(domain, 'PermissionsUtil', `Failed to check access token. Code: ${err.code}, message: ${err.message}`);
    }

    return grantStatus;
  }

  requestPermissions(permissions: Array<Permissions>): void {
    const atManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext, permissions)
      .then((_data: PermissionRequestResult) => {
        hilog.info(domain, 'PermissionsUtil', 'Request permissions success');
      })
      .catch((err: BusinessError) => {
        hilog.error(domain, 'PermissionsUtil', `Failed to request permissions. Code: ${err.code}, message: ${err.message}`);
      });
  }

  async requestPermission(permissions: Permissions[], context: common.UIAbilityContext): Promise<boolean> {
    const atManager = abilityAccessCtrl.createAtManager();
    const result = await atManager.requestPermissionsFromUser(context, permissions);
    return !!result.authResults.length && result.authResults.every(authResults => authResults === 0);
  }
}

export default PermissionsUtil.getInstance();
