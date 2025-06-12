#!/usr/bin/env python3
# File: google.py
# Author: Oluwatobiloba Light
"""Google Auth"""


import os
from typing import Any, List, Mapping, Optional, Tuple
import google.auth
import google.auth.exceptions
import google.auth.transport
import google.auth.transport.requests
from google_auth_oauthlib.flow import Flow
import oauthlib
import oauthlib.oauth2.rfc6749
import google.oauth2.id_token

from app.core.config import configs
from google_auth_oauthlib.flow import InstalledAppFlow


# flow = Flow.from_client_secrets_file(
#     client_secrets_file=configs.GOOGLE_CLIENT,
#     redirect_uri=configs.GOOGLE_REDIRECT_URI,
#     scopes=configs.GOOGLE_SCOPES)

class GoogleAuth:
    """Google Authentication"""
    # flow:  Flow

    def __init__(self, client_secrets_file: str, redirect_uri: str, scopes: List[str]):
        self.flow: Flow = Flow.from_client_secrets_file(
            client_secrets_file=client_secrets_file, redirect_uri=redirect_uri, scopes=scopes)

    def get_google_auth_state(self) -> Tuple[str, str]:
        """Get google auth state"""
        authorization_url, state = self.flow.authorization_url(
            # Recommended, enable offline access so that you can refresh an access token without
            # re-prompting the user for permission. Recommended for web server apps.
            access_type='offline',
            # # Optional, enable incremental authorization. Recommended as a best practice.
            include_granted_scopes='true',
            # # Recommended, state value can increase your assurance that an incoming connection is the result
            # # of an authentication request.
            # state=state,
            # # Optional, if your application knows which user is trying to authenticate, it can use this
            # # parameter to provide a hint to the Google Authentication Server.
            # login_hint='hint@example.com',
            # # Optional, set prompt to 'consent' will prompt the user for consent
            prompt='consent'
        )
        return (authorization_url, state)

    def google_auth_flow(self, code: str) -> Optional[Flow]:
        """"""
        try:
            self.flow.fetch_token(code=code)
            return self.flow
        except (oauthlib.oauth2.rfc6749.errors.InvalidGrantError, oauthlib.oauth2.rfc6749.errors.CustomOAuth2Error) as e:
            print("error has", e)
            return None

    def verify_google_token(self, id_token: Any) -> Optional[Mapping[str, Any]]:
        """Verify google token"""
        token_request = google.auth.transport.requests.Request()

        try:
            user_info = google.oauth2.id_token.verify_oauth2_token(
                id_token=id_token, request=token_request,
                audience=configs.GOOGLE_CLIENT_ID)

            return user_info
        except (google.auth.exceptions.InvalidValue,
                google.auth.exceptions.InvalidOperation) as e:
            return None

import codecs

google_login_auth = GoogleAuth(client_secrets_file=configs.GOOGLE_CLIENT,
                         redirect_uri=configs.GOOGLE_LOGIN_REDIRECT_URI if configs.ENV == "production" else codecs.decode(configs.GOOGLE_LOCAL_LOGIN_REDIRECT_URI, "unicode_escape"), scopes=configs.GOOGLE_SCOPES)

google_register_auth = GoogleAuth(client_secrets_file=configs.GOOGLE_CLIENT,
                                          redirect_uri=configs.GOOGLE_REGISTER_REDIRECT_URI if configs.ENV == "production" else codecs.decode(configs.GOOGLE_LOCAL_REGISTER_REDIRECT_URI, "unicode_escape"), scopes=configs.GOOGLE_SCOPES)
